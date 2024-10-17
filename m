Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E01DE3CB
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173345; cv=none; b=krVX5PPdarLy6JnTPVZqaqq/LliqhNtLEgJeb4rfPr1OxburdKy0bPoCp2RlVzWH1iTcWwRSRoc01/PEtUnhSUposQhZUdOXdilZDa0Fhl1z45mvF1bWwDoanrPXYf+0c+kO/9Wf327206kjN/Bv8GJcHqAmjBEF+KM5vM/c20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173345; c=relaxed/simple;
	bh=/uaz8mJIkNrF5cJ5tn1a/1JAiJqh/EQZveUXTrvM9SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlBjU5i4EWMpHD+gJaa4Tdi74uFLPXaBaHRPH+8brFR5s/gyimIoIH6MHGudKETbxLFGD4rjccfWwsp4P3JIT4njyqOTcDL/KqcaI9pRFOfDM1vySkNbb/k0yT8g5S1COXzfXZ/L2M0HE6doaAi1Gv7SQrA1zeWRrNqSbskLCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DltJ9ZGe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DltJ9ZGe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729173339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWhsnSG506qWu8kJKmjsHiZZG+/rDRjouDjfeBRbR+4=;
	b=DltJ9ZGeISZjIHv6CNmOB2EU+7q8v7txJIty7MYKpcD9SHRbg1J4Yt4JYF4Z97fGVCv4J/
	7VUbYO0ookUs3pX3Uxi10FMI+u/Y8/Z3+S0w7watQpFV0a/OBloP9+fx5wztOQn9VmdwZ+
	1MTMwlTQFkCEhxgg6h92ebIJj4+aOLk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-xq3-0qFANfmPogXZAOM_-g-1; Thu, 17 Oct 2024 09:55:38 -0400
X-MC-Unique: xq3-0qFANfmPogXZAOM_-g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d45f1e935so456177f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 06:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729173336; x=1729778136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWhsnSG506qWu8kJKmjsHiZZG+/rDRjouDjfeBRbR+4=;
        b=Lhe3sWUvgPrN8KwaWzfQYGXDPiizHZ0s8d2L+TXL9COXTkm5hs7Vr4VpsPW057/4Er
         8X9wTBttroY1PecdkEOp1sO6xQmUvKe0bEqBlpTWDk7d/KzZgRlB7tawzY0nkeHw0PdE
         1PqlSj4GYEsOQ2ZYPYbBSwluHD4z3Y12x2ADgW7kccO/Fcv0IfFrRnFJEeaWuBOTN/TW
         5iIhzVdQm6u031RhElw39BvILJOaEzu7Ok75t85pvhq3v5fpLuGAPtnwYsQieQv5v2y8
         Adz9cb4Dbnz4dpvTaJkd0uSFraPUN7NbPsj3kp3jIEO3Kq48iF7GM9t7Faa+sdMRr+UY
         oqjA==
X-Gm-Message-State: AOJu0YxCZmMHJu3EDABsSZSibx6dsZeX6npE1DbK41zGFM4mNn0VOmCX
	K3F3SL2cJpZqs/thyB6T72+HvWCGuaHdb65SyXNTfQluV5MQDxyFZRwxzbutnxxWudgsHSuGQ6D
	TBY/tWVl4GBEcqeGJ2dsZNwPrXqg++vJONzTebr6DL2qVTwDYvDAPyplQWP9D5AXQ5LE=
X-Received: by 2002:a05:6000:1376:b0:37c:babe:2c49 with SMTP id ffacd0b85a97d-37d5feff423mr13840642f8f.19.1729173336041;
        Thu, 17 Oct 2024 06:55:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIvNnKtYv+J9O0A1VUztBxi7ytW3jlDWFxDqfxGS/iAYg2E9xAtbNSSQsKg+9xZidV0kwzJw==
X-Received: by 2002:a05:6000:1376:b0:37c:babe:2c49 with SMTP id ffacd0b85a97d-37d5feff423mr13840629f8f.19.1729173335524;
        Thu, 17 Oct 2024 06:55:35 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c39806sm26969975e9.11.2024.10.17.06.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 06:55:35 -0700 (PDT)
Message-ID: <7d306fb3-43ba-4691-9302-47d69f8ab183@redhat.com>
Date: Thu, 17 Oct 2024 15:55:33 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Handle perftool-testsuite_probe failure due to
 broken DWARF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com,
 peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-kernel@vger.kernel.org
References: <20241016091930.191761-1-vmolnaro@redhat.com>
 <Zw_mutl867MINXPi@x1>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <Zw_mutl867MINXPi@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/16/24 18:15, Arnaldo Carvalho de Melo wrote:
> On Wed, Oct 16, 2024 at 11:19:30AM +0200, vmolnaro@redhat.com wrote:
>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>
>> Test case test_adding_blacklisted ends in failure if the blacklisted
>> probe is of an assembler function with no DWARF available. At the same=

>> time, probing the blacklisted function with ASM DWARF doesn't test the=

>> blacklist itself as the failure is a result of the broken DWARF.
>>
>> When the broken DWARF output is encountered, check if the probed
>> function was compiled by the assembler. If so, the broken DWARF messag=
e
>> is expected and does not report a perf issue, else report a failure.
>> If the ASM DWARF affected the probe, try the next probe on the blackli=
st.
>> If the first 5 probes are defective due to broken DWARF, skip the test=

>> case.
>>
>> Fixes: def5480d63c1e847 ("perf testsuite probe: Add test for blacklist=
ed kprobes handling")
>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>> ---
>>  .../base_probe/test_adding_blacklisted.sh     | 74 +++++++++++++++---=
-
>>  1 file changed, 59 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted=
=2Esh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
>> index b5dc10b2a73810b3..f67b3b267ac55269 100755
>> --- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
>> +++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
>> @@ -19,35 +19,79 @@
>>  TEST_RESULT=3D0
>> =20
>>  # skip if not supported
>> -BLACKFUNC=3D`head -n 1 /sys/kernel/debug/kprobes/blacklist 2> /dev/nu=
ll | cut -f2`
>> -if [ -z "$BLACKFUNC" ]; then
>> +BLACKFUNC_LIST=3D`head -n 5 /sys/kernel/debug/kprobes/blacklist 2> /d=
ev/null | cut -f2`
>> +if [ -z "$BLACKFUNC_LIST" ]; then
>>  	print_overall_skipped
>>  	exit 0
>>  fi
>> =20
>> +# chceck if locate is present to find vmlinux with DWARF debug info
>=20
> check
>=20
>> +locate --help 2&> /dev/null
>> +if [ $? -eq 0 ]; then
>> +	VMLINUX_FILE=3D$(locate -r '/vmlinux$' | xargs -I{} sh -c 'test -f "=
{}" && echo "{}"' | grep "$(uname -r)")
>> +fi
>=20
> And that matches the running kernel? Maybe its better to use 'perf
> probe' itself to find it:
>=20
>   root@number:~# perf probe -V icmp_rcv
>   Available variables at icmp_rcv
>           @<icmp_rcv+0>
>                   struct sk_buff* skb
>   root@number:~# perf probe -v -V icmp_rcv |& grep "Using.*for symbols"=

>   Using /usr/lib/debug/lib/modules/6.11.3-200.fc40.x86_64/vmlinux for s=
ymbols
>   root@number:~# perf probe -v -V icmp_rcv |& grep "Using.*for symbols"=
 | sed -r 's/^Using (.*) for symbols$/\1/'
>   /usr/lib/debug/lib/modules/6.11.3-200.fc40.x86_64/vmlinux
>   root@number:~#
>=20
Well, it was the best solution we could find, but using 'perf probe' migh=
t be
a better solution to it. It seems that 'perf probe' prints the using log =
line
even if the probe doesn't exist:

    [root@intel-sharkbay-mb-01 ~]# perf probe -v random_probe
    probe-definition(0): random_probe=20
    symbol:random_probe file:(null) line:0 offset:0 return:0 lazy:(null)
    0 arguments
    Looking at the vmlinux_path (8 entries long)
    Using /usr/lib/debug/lib/modules/5.14.0-364.3026_999908015.el9.x86_64=
/vmlinux for symbols
    Open Debuginfo file: /usr/lib/debug/.build-id/97/52ebee3cc94ca35fbbaa=
fc9abf3cbacb34d4d1.debug
    Try to find probe point from debuginfo.
    Probe point 'random_probe' not found.
      Error: Failed to add events. Reason: No such device (Code: -19)

Thanks, will rework that to grep the vmlinux from the 'perf probe -v' out=
put instead.
> I'll probably add something like this to 'perf buildid-list':
>=20
> root@number:~# pahole --running_kernel_vmlinux
> /usr/lib/debug/lib/modules/6.11.3-200.fc40.x86_64/vmlinux
> root@number:~# readelf -wi `pahole --running_kernel_vmlinux` | head -12=

> Contents of the .debug_info section:
>=20
>   Compilation Unit @ offset 0:
>    Length:        0x2b082 (32-bit)
>    Version:       5
>    Unit Type:     DW_UT_compile (1)
>    Abbrev Offset: 0
>    Pointer Size:  8
>  <0><c>: Abbrev Number: 246 (DW_TAG_compile_unit)
>     <e>   DW_AT_producer    : (indirect string, offset: 0x4eda9f): GNU =
C11 14.2.1 20240912 (Red Hat 14.2.1-3) -mno-sse -mno-mmx -mno-sse2 -mno-3=
dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-bounda=
ry=3D3 -mskip-rax-setup -mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel =
-mindirect-branch=3Dthunk-extern -mindirect-branch-register -mindirect-br=
anch-cs-prefix -mfunction-return=3Dthunk-extern -mharden-sls=3Dall -mreco=
rd-mcount -mfentry -march=3Dx86-64 -g -O2 -std=3Dgnu11 -p -fshort-wchar -=
funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -fcf-protection=3D=
branch -falign-jumps=3D1 -falign-loops=3D1 -fno-asynchronous-unwind-table=
s -fno-jump-tables -fpatchable-function-entry=3D16,16 -fno-delete-null-po=
inter-checks -fno-allow-store-data-races -fstack-protector-strong -ftrivi=
al-auto-var-init=3Dzero -fno-stack-clash-protection -fmin-function-alignm=
ent=3D16 -fstrict-flex-arrays=3D3 -fno-strict-overflow -fstack-check=3Dno=
 -fconserve-stack -fno-function-sections -fno-data-sections -fsanitize=3D=
bounds-strict -fsanitize=3Dshift
>     <12>   DW_AT_language    : 29	(C11)
>     <13>   DW_AT_name        : (indirect line string, offset: 0xa546): =
init/main.c
> root@number:~#
>=20
>> +
>>  # remove all previously added probes
>>  clear_all_probes
>> =20
>> =20
>>  ### adding blacklisted function
>> -
>> -# functions from blacklist should be skipped by perf probe
>> -! $CMD_PERF probe $BLACKFUNC > $LOGS_DIR/adding_blacklisted.log 2> $L=
OGS_DIR/adding_blacklisted.err
>> -PERF_EXIT_CODE=3D$?
>> -
>>  REGEX_SCOPE_FAIL=3D"Failed to find scope of probe point"
>>  REGEX_SKIP_MESSAGE=3D" is blacklisted function, skip it\."
>> -REGEX_NOT_FOUND_MESSAGE=3D"Probe point \'$BLACKFUNC\' not found."
>> +REGEX_NOT_FOUND_MESSAGE=3D"Probe point \'$RE_EVENT\' not found."
>>  REGEX_ERROR_MESSAGE=3D"Error: Failed to add events."
>>  REGEX_INVALID_ARGUMENT=3D"Failed to write event: Invalid argument"
>>  REGEX_SYMBOL_FAIL=3D"Failed to find symbol at $RE_ADDRESS"
>> -REGEX_OUT_SECTION=3D"$BLACKFUNC is out of \.\w+, skip it"
>> -../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NO=
T_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVAL=
ID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding=
_blacklisted.err
>> -CHECK_EXIT_CODE=3D$?
>> -
>> -print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted fu=
nction $BLACKFUNC"
>> -(( TEST_RESULT +=3D $? ))
>> -
>> +REGEX_OUT_SECTION=3D"$RE_EVENT is out of \.\w+, skip it"
>> +REGEX_MISSING_DECL_LINE=3D"A function DIE doesn't have decl_line. May=
be broken DWARF?"
>> +
>> +BLACKFUNC=3D""
>> +SKIP_DWARF=3D0
>> +
>> +for BLACKFUNC in $BLACKFUNC_LIST; do
>> +	echo "Probing $BLACKFUNC"
>> +
>> +	# functions from blacklist should be skipped by perf probe
>> +	! $CMD_PERF probe $BLACKFUNC > $LOGS_DIR/adding_blacklisted.log 2> $=
LOGS_DIR/adding_blacklisted.err
>> +	PERF_EXIT_CODE=3D$?
>> +
>> +	# check for bad DWARF polluting the result
>> +	../common/check_all_patterns_found.pl "$REGEX_MISSING_DECL_LINE" >/d=
ev/null < $LOGS_DIR/adding_blacklisted.err
>> +
>> +	if [ $? -eq 0 ]; then
>> +		SKIP_DWARF=3D1
>> +
>> +		# confirm that the broken DWARF comes from assembler
>> +		if [ -n "$VMLINUX_FILE" ]; then
>> +			readelf -wi "$VMLINUX_FILE" |
>=20
> Can you cache the output of 'readelf -wi' for the whole vmlinux file so=

> that we don't do it more than once?
>=20
> Doing it for each assembly function in the blacklist probably will add
> up on this test run time.
>=20
I am not sure if it is possible to cache the whole output somehow
as my tested system takes a minute if I try to print the output
of the 'readlef -wi'. To add to that, I do not need the whole
vmlinux file as I am exiting as soon I as find the blacklisted_probe in
the output.

About the test run time, I checked how long it takes to find the probe in=

the 'readelf -wi' output using awk and it is about 2 seconds per probe:

    [root@intel-sharkbay-mb-01 ~]# time readelf -wi "$VMLINUX_FILE" | awk=
 -v probe=3D"asm_exc_device_not_available" '/DW_AT_language/ { comp_lang =
=3D $0 } $0 ~ probe { if (comp_lang) { print comp_lang }; exit }'
        <41fc04>   DW_AT_language    : 29	(C11)

    real	0m1.509s
    user	0m1.979s
    sys		0m0.173s
=20
This depends on the probe so some might take longer than that. Doing it
repeatedly for multiple probes is not the default behavior anyway, as
this only happens if there are multiple assembly functions at the
start of the blacklist in a row. Currently, we know only about one
of such functions, which is warn_thunk_thunk. If the run time will be
the issue, I think we would have to address the issue differently.

>> +			awk -v probe=3D"$BLACKFUNC" '/DW_AT_language/ { comp_lang =3D $0 }=

>> +										$0 ~ probe { if (comp_lang) { print comp_lang }; exit }' |
>> +			grep -q "MIPS assembler"
>> +
>> +			CHECK_EXIT_CODE=3D$?
>> +			if [ $CHECK_EXIT_CODE -ne 0 ]; then
>> +				SKIP_DWARF=3D0 # broken DWARF while available
>> +				break
>> +			fi
>> +		else
>> +			echo "Result polluted by broken DWARF, trying another probe"
>> +		fi
>> +
>> +	else
>> +		../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_=
NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INV=
ALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/addi=
ng_blacklisted.err
>> +		CHECK_EXIT_CODE=3D$?
>> +
>> +		SKIP_DWARF=3D0
>> +		break
>> +	fi
>> +done
>> +
>> +if [ $SKIP_DWARF -eq 1 ]; then
>> +	print_testcase_skipped "adding blacklisted function $BLACKFUNC"
>> +else
>> +	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted f=
unction $BLACKFUNC"
>> +	(( TEST_RESULT +=3D $? ))
>> +fi
>> =20
>>  ### listing not-added probe
>> =20
>> --=20
>> 2.43.0
>>
>=20

