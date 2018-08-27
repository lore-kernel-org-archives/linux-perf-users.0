From: =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: Re: [PATCH] Properly interpret indirect call in perf annotate.
Date: Mon, 27 Aug 2018 16:28:00 +0200
Message-ID: <3e0c89cf-3e2a-5e23-7921-123a061f3558@suse.cz>
References: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
 <20180827103715.GB8065@sejong>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------6A763E9AD35B1793E37A0A8C"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827103715.GB8065@sejong>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------6A763E9AD35B1793E37A0A8C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 08/27/2018 12:37 PM, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Aug 23, 2018 at 02:29:34PM +0200, Martin Liška wrote:
>> The patch changes interpretation of:
>> callq  *0x8(%rbx)
>>
>> from:
>>   0.26 │     → callq  *8
>> to:
>>   0.26 │     → callq  *0x8(%rbx)
>>
>> in this can an address is followed by a register, thus
>> one can't parse only address.
> 
> Also there's a case with no offset like:  callq  *%rbx

Yes. But this case is fine as strtoull returns 0 for that:
'If there were no digits at all, strtoul() stores the original value of nptr in *endptr (and returns 0).'
So ops->target.addr is then 0 and it's fine.

> 
> 
>>
>> Signed-off-by: Martin Liška <mliska@suse.cz>
>> ---
>>  tools/perf/util/annotate.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>>
> 
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index e4268b948e0e..e32ead4744bd 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -246,8 +246,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
>>  
>>  indirect_call:
>>  	tok = strchr(endptr, '*');
>> -	if (tok != NULL)
>> -		ops->target.addr = strtoull(tok + 1, NULL, 16);
>> +	if (tok != NULL) {
>> +		endptr++;
>> +
>> +		/* Indirect call can use a non-rip register and offset: callq  *0x8(%rbx).
>> +		 * Do not parse such instruction.  */
>> +		if (strstr(endptr, "(%r") == NULL)
>> +			ops->target.addr = strtoull(endptr, NULL, 16);
> 
> It seems too x86-specific, what about this? (not tested)

It is, I'm fine with that. I've just tested that for the callq  *0x8(%rbx) example.
I'm sending patch for that version.

Martin

> 
> 
> indirect_call:
> 	tok = strchr(endptr, '*');
> 	if (tok != NULL) {
> 		endptr++;
> 		if (!isdigit(*endptr))
> 			return 0;
> 
> 		addr = strtoull(endptr, &endptr, 0);
> 		if (*endptr != '('))
> 			ops->target.addr = addr;
> 
> 
> Thanks,
> Namhyung
> 
> 
>> +	}
>>  	goto find_target;
>>  }
>>  
>>
> 


--------------6A763E9AD35B1793E37A0A8C
Content-Type: text/x-patch;
 name="0001-Properly-interpret-indirect-call-in-perf-annotate.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-Properly-interpret-indirect-call-in-perf-annotate.patch"

From 58a0eca544be8cc9e15b2ab5ecd9d9401ff4d2ec Mon Sep 17 00:00:00 2001
From: marxin <mliska@suse.cz>
Date: Thu, 23 Aug 2018 14:25:33 +0200
Subject: [PATCH] Properly interpret indirect call in perf annotate.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch changes interpretation of:
callq  *0x8(%rbx)

from:
  0.26 │     → callq  *8
to:
  0.26 │     → callq  *0x8(%rbx)

in this can an address is followed by a register, thus
one can't parse only address.

Signed-off-by: Martin Liška <mliska@suse.cz>
---
 tools/perf/util/annotate.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e4268b948e0e..18a8477d4664 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -212,6 +212,7 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	struct addr_map_symbol target = {
 		.map = map,
 	};
+  u64 addr;
 
 	ops->target.addr = strtoull(ops->raw, &endptr, 16);
 
@@ -246,8 +247,15 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 
 indirect_call:
 	tok = strchr(endptr, '*');
-	if (tok != NULL)
-		ops->target.addr = strtoull(tok + 1, NULL, 16);
+	if (tok != NULL) {
+		endptr++;
+		if (!isdigit(*endptr))
+			return 0;
+
+		addr = strtoull(endptr, &endptr, 0);
+		if (*endptr != '(')
+			ops->target.addr = addr;
+	}
 	goto find_target;
 }
 
-- 
2.18.0


--------------6A763E9AD35B1793E37A0A8C--
