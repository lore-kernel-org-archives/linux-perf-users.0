From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390
 auxiliary trace
Date: Wed, 8 Aug 2018 08:39:58 +0200
Message-ID: <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-3-tmricht@linux.ibm.com>
 <87r2j9bkax.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------13D9DBA6A4F3C4927657562D"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87r2j9bkax.fsf@concordia.ellerman.id.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: mpe@ellerman.id.au, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------13D9DBA6A4F3C4927657562D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 08/08/2018 05:37 AM, mpe@ellerman.id.au wrote:
> Thomas Richter <tmricht@linux.ibm.com> writes:
>> Add support for s390 auxiliary trace support.
>> Use 'perf record -e rbd000' to create the perf.data file.
>> The event also has the symbolic name SF_CYCLES_BASIC_DIAG,
>> using 'perf record -e SF_CYCLES_BASIC_DIAG' is equivalent.
> ...
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
>> ---
>>  tools/perf/util/s390-cpumsf-kernel.h |  71 ++++++++
>>  tools/perf/util/s390-cpumsf.c        | 244 ++++++++++++++++++++++++++-
>>  2 files changed, 314 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/perf/util/s390-cpumsf-kernel.h
> 
> 
> I'm seeing a build break on ppc64le which seems to be caused by this
> commit (I haven't bisected):
> 
>   util/s390-cpumsf.c: In function ‘trailer_timestamp’:
>   util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
>     return *((unsigned long long *) &te->timestamp[te->t]);
>     ^
> 
> 
> And on powerpc big endian:
>   In file included from util/cpumap.h:10:0,
>                    from util/s390-cpumsf.c:150:
>   util/s390-cpumsf.c: In function ‘s390_cpumsf_basic_show’:
>   util/s390-cpumsf.c:187:10: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘size_t {aka unsigned int}’ [-Werror=format=]
>      pr_err("Invalid AUX trace basic entry [%#08lx]\n", pos);
>             ^
> 
> cheers
> 

Can you please try this patch. Thanks a lot

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

--------------13D9DBA6A4F3C4927657562D
Content-Type: text/x-patch;
 name="0001-perf-report-Fix-build-error-for-s390-auxiliary-trace.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-perf-report-Fix-build-error-for-s390-auxiliary-trace.pa";
 filename*1="tch"

From add6a709f79e20e8b4eaa6ded2bd1af043f8a235 Mon Sep 17 00:00:00 2001
From: Thomas Richter <tmricht@linux.ibm.com>
Date: Wed, 8 Aug 2018 07:11:23 +0100
Subject: [PATCH] perf report: Fix build error for s390 auxiliary trace support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 73eeeea48b7e ("perf report: Add raw report support for s390 auxiliary trace")
introduced a compile errors on powerpc:
  util/s390-cpumsf.c: In function ‘trailer_timestamp’:
  util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will
	break strict-aliasing rules [-Werror=strict-aliasing]
	return *((unsigned long long *) &te->timestamp[te->t]);
	^

  In file included from util/cpumap.h:10:0,
                   from util/s390-cpumsf.c:150:
  util/s390-cpumsf.c: In function ‘s390_cpumsf_basic_show’:
  util/s390-cpumsf.c:187:10: error: format ‘%lx’ expects argument of type
	‘long unsigned int’, but argument 4 has type
	‘size_t {aka unsigned int}’ [-Werror=format=]
     pr_err("Invalid AUX trace basic entry [%#08lx]\n", pos);
            ^

Fix these errors:
1. Use memcpy to extract value from character array.
2. Use %zu as format string in pr_err

Fixes: 73eeeea48b7e
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/s390-cpumsf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 15555604ddb3..2bcb160a08f0 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -184,7 +184,7 @@ static bool s390_cpumsf_basic_show(const char *color, size_t pos,
 				   struct hws_basic_entry *basic)
 {
 	if (basic->def != 1) {
-		pr_err("Invalid AUX trace basic entry [%#08lx]\n", pos);
+		pr_err("Invalid AUX trace basic entry [%#08zx]\n", pos);
 		return false;
 	}
 	color_fprintf(stdout, color, "    [%#08x] Basic   Def:%04x Inst:%#04x"
@@ -219,7 +219,10 @@ static unsigned long long trailer_timestamp(struct hws_trailer_entry *te)
 	/* te->t set: TOD in STCKE format, bytes 8-15
 	 * to->t not set: TOD in STCK format, bytes 0-7
 	 */
-	return *((unsigned long long *) &te->timestamp[te->t]);
+	unsigned long long ts;
+
+	memcpy(&ts, &te->timestamp[te->t], sizeof(ts));
+	return ts;
 }
 
 /* Display s390 CPU measurement facility trailer entry */
-- 
2.14.3


--------------13D9DBA6A4F3C4927657562D--
