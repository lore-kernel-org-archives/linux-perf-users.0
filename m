From: "David S. Ahern" <daahern@cisco.com>
Subject: Re: [PATCH] perf symbols: reuse of name in dso__load when starting
 second pass
Date: Sun, 21 Nov 2010 17:50:46 -0700
Message-ID: <4CE9BE66.3060109@cisco.com>
References: <1290351830-4398-1-git-send-email-daahern@cisco.com> <20101121220337.GB4056@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-4.cisco.com ([171.68.10.86]:33529 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838Ab0KVAur (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 21 Nov 2010 19:50:47 -0500
In-Reply-To: <20101121220337.GB4056@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org



On 11/21/10 15:03, Arnaldo Carvalho de Melo wrote:
> Em Sun, Nov 21, 2010 at 08:03:50AM -0700, David Ahern escreveu:
>> continue statement in default case applies when a second pass is
>> wanted as well. As it stands the code drops down to the open
>> re-using the value in name from the previous origin attempt.
>>
>> Signed-off-by: David Ahern <daahern@cisco.com>
>> ---
>>  tools/perf/util/symbol.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>> index d30136e..861be8b 100644
>> --- a/tools/perf/util/symbol.c
>> +++ b/tools/perf/util/symbol.c
>> @@ -1488,8 +1488,8 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
>>  			if (want_symtab) {
>>  				want_symtab = 0;
>>  				self->origin = DSO__ORIG_BUILD_ID_CACHE;
>> -			} else
>> -				continue;
>> +			}
>> +			continue;
>>  		}
> 
> But we want to restart at DSO__ORIG_BUILD_ID_CACHE, right? If you do
> your change we keep a existing mistake and will instead restart at
> DSO__ORIG_BUILD_ID_CACHE + 1, please take a look to validate my
> understanding that we need to set self->origin to
> DSO__ORIG_BUILD_ID_CACHE - 1.

Correct. In working on the rootfs change I noticed that the default case
falls through to the open using the 'name' value set from the previous
origin so it is tried twice. This patch fixes that bug.

I also noted that the BUILD_ID_CACHE was skipped, but I was not sure if
that was desired or not. If it is then correcting the proper 'next
origin' is another trivial bug fix.

Some projects like single focused bug fixes for bisecting. I am fine
with combining if that is wanted.

David


> 
> - Arnaldo
