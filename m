From: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH v4] tools/perf: Allow user probes on versioned symbols
Date: Thu, 6 Apr 2017 10:56:46 -0500
Message-ID: <136b951a-8a05-188e-c861-3ca3e4479354@us.ibm.com>
References: <a459fae5-19e8-207b-6ec0-addd39b6417d@us.ibm.com>
 <20170406143606.GA2966@kernel.org>
Reply-To: pc@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50429 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755123AbdDFP4x (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Apr 2017 11:56:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v36Frg7f124512
        for <linux-perf-users@vger.kernel.org>; Thu, 6 Apr 2017 11:56:53 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 29nerfrbdq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Apr 2017 11:56:52 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <pc@us.ibm.com>;
        Thu, 6 Apr 2017 09:56:51 -0600
In-Reply-To: <20170406143606.GA2966@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, David Ahern <dsahern@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 04/06/2017 09:36 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 05, 2017 at 10:30:03PM -0500, Paul Clarke escreveu:
>> Symbol versioning, as in glibc, results in symbols being defined as:
>> <real symbol>@[@]<version>
>> (Note that "@@" identifies a default symbol, if the symbol name
>> is repeated.)
>>
>> perf is currently unable to deal with this, and is unable to create
>> user probes at such symbols:
>> --
>> $ nm /lib/powerpc64le-linux-gnu/libpthread.so.0 | grep pthread_create
>> 0000000000008d30 t __pthread_create_2_1
>> 0000000000008d30 T pthread_create@@GLIBC_2.17
>> $ /usr/bin/sudo perf probe -v -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create
>> probe-definition(0): pthread_create
>> symbol:pthread_create file:(null) line:0 offset:0 return:0 lazy:(null)
>> 0 arguments
>> Open Debuginfo file: /usr/lib/debug/lib/powerpc64le-linux-gnu/libpthread-2.19.so
>> Try to find probe point from debuginfo.
>> Probe point 'pthread_create' not found.
>>    Error: Failed to add events. Reason: No such file or directory (Code: -2)
>> --
>>
>> One is not able to specify the fully versioned symbol, either, due to
>> syntactic conflicts with other uses of "@" by perf:
>> --
>> $ /usr/bin/sudo perf probe -v -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create@@GLIBC_2.17
>> probe-definition(0): pthread_create@@GLIBC_2.17
>> Semantic error :SRC@SRC is not allowed.
>> 0 arguments
>>    Error: Command Parse Error. Reason: Invalid argument (Code: -22)
>> --
>>
>> This patch ignores the versioning tag for default symbols, thus
>> allowing probes to be created for these symbols:
>> --
>> $ /usr/bin/sudo ./perf probe -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create
>> Added new event:
>>    probe_libpthread:pthread_create (on pthread_create in /lib/powerpc64le-linux-gnu/libpthread-2.19.so)
>>
>> You can now use it in all perf tools, such as:
>>
>>          perf record -e probe_libpthread:pthread_create -aR sleep 1
>>
>> $ /usr/bin/sudo ./perf record -e probe_libpthread:pthread_create -aR ./test 2
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.052 MB perf.data (2 samples) ]
>> $ /usr/bin/sudo ./perf script
>>              test  2915 [000] 19124.260729: probe_libpthread:pthread_create: (3fff99248d38)
>>              test  2916 [000] 19124.260962: probe_libpthread:pthread_create: (3fff99248d38)
>> $ /usr/bin/sudo ./perf probe --del=probe_libpthread:pthread_create
>> Removed event: probe_libpthread:pthread_create
>> --
>>
>> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
>> ---
>> v4:
>> - rebased to acme/perf/core
>> - moved changes from "map" namespace to "symbol" namespace,
>> - rewrote symbol__compare (now *match) to avoid need for strdup
>> - new symbol__match_symbol_name to support versioned symbols, ignoring default
>>   tags
>> - new arch__compare_symbol_names_n to map to strncmp
>> - dso__find_symbol_by_name: now tries exact match (as before), then tries
>>    also adding symbols tagged as default (@@)
>> - symbols__find_by_name: new parameter to support finding with or without default
>>   tags
>> - does NOT handle setting probes using the tagged symbol name (symbol@[@]tag)
>>
>> v3:
>> - code style fixes per David Ahern
>>
>> v2:
>> - move logic from arch__compare_symbol_names to new map__compare_symbol_names
>> - call through from map__compare_symbol_names to arch__compare_symbol_names
>> - redirect uses of arch__compare_symbol_names
>> - send patch to LKML
>>  tools/perf/arch/powerpc/util/sym-handling.c | 12 ++++++
>>  tools/perf/util/map.c                       |  5 ---
>>  tools/perf/util/map.h                       |  5 ++-
>>  tools/perf/util/symbol.c                    | 62 +++++++++++++++++++++++------
>>  tools/perf/util/symbol.h                    |  9 +++++
>>  5 files changed, 73 insertions(+), 20 deletions(-)
[...]
>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>> index 9b4d8ba..c29440d 100644
>> --- a/tools/perf/util/symbol.c
>> +++ b/tools/perf/util/symbol.c
>> @@ -87,6 +87,17 @@ static int prefix_underscores_count(const char *str)
>>  	return tail - str;
>>  }
>> +int __weak arch__compare_symbol_names(const char *namea, const char *nameb)
>> +{
>> +	return strcmp(namea, nameb);
>> +}
>> +
>> +int __weak arch__compare_symbol_names_n(const char *namea, const char *nameb,
>> +					unsigned int n)
>> +{
>> +	return strncmp(namea, nameb, n);
>> +}
>> +
>>  int __weak arch__choose_best_symbol(struct symbol *syma,
>>  				    struct symbol *symb __maybe_unused)
>>  {
>> @@ -396,8 +407,26 @@ static void symbols__sort_by_name(struct rb_root *symbols,
>>  	}
>>  }
>> +int symbol__match_symbol_name(const char *name, const char *str,
>> +	int including_tags)
>> +{
>> +	const char *versioning;
>> +
>> +	if (including_tags == SYMBOLS__TAG_INCLUDE_DEFAULT_ONLY &&
>> +	    (versioning = strstr(name,"@@"))) {
>> +
>> +		unsigned int len = strlen(str);
>> +		if (len < versioning - name)
>> +			len = versioning - name;
>> +
>> +		return arch__compare_symbol_names_n(name, str, len);
>> +	} else
>> +		return arch__compare_symbol_names(name, str);
>> +}
>> +
>>  static struct symbol *symbols__find_by_name(struct rb_root *symbols,
>> -					    const char *name)
>> +					    const char *name,
>> +					    unsigned int including_tags)
>>  {
>>  	struct rb_node *n;
>>  	struct symbol_name_rb_node *s = NULL;
>> @@ -411,11 +440,12 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
>>  		int cmp;
>>  		s = rb_entry(n, struct symbol_name_rb_node, rb_node);
>> -		cmp = arch__compare_symbol_names(name, s->sym.name);
>> +		cmp = symbol__match_symbol_name(s->sym.name, name,
>> +						 including_tags);
>> -		if (cmp < 0)
>> +		if (cmp > 0)
>>  			n = n->rb_left;
>> -		else if (cmp > 0)
>> +		else if (cmp < 0)
>
> What is this inversion of left/right for? Why the new cmp function
> inverts the results? does it really?

Good question.  I changed the symbol/string matching function from a "compare two strings exactly" function to a "match a (possibly versioned) symbol name with a string" function.  A small optimization, to avoid worrying about both strings being versioned, is that the new function's API expects the possibly versioned symbol name as the first parameter, and the string as the 2nd.  I figured the first parameter is the most significant and should be the symbol.  That forced the parameter reversal, and the subsequent comparison inversions.


>>  			n = n->rb_right;
>>  		else
>>  			break;

PC
