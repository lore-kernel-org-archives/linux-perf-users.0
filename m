Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F21F3B92;
	Mon,  3 Mar 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003614; cv=none; b=WxMqaVjmILS/c823E+HDSRcNWIVyMXymqQWrlKIP74ivTvpYfT86jVEI2pzGxER/At9CU7pvFZgz2o6rXyL2eIE50AS/GiDeXpLESLZAtUHpoI/woj8tBoVbANQ058JEsKe5mHjIBi2Nh1M0BuPJ7HHQ9CpKgnTP7eD3/4YeNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003614; c=relaxed/simple;
	bh=Gl6qiIcOyGrEhzAlUso1MTAx6dr5TcFXxigud7IYfDs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kvBLDkwyW6YmxUX8lLZ1ovzN5zPdu5mlpb1TBauRGdSgWjCXplRtp722E302InjjtZmH9YEgQqLVy0NbrhvSZ9gQNQBDZHVLKN4PIoRLXaFS3lT7ogxWZ2evE/tgpu9eclDNMHkCWGdT6EwworY5sRnseaKKT+lTZu1WNIbQBJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=uswEK2tY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uswEK2tY"
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 523C5tOu1574873
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Mar 2025 04:05:55 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 523C5tOu1574873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741003556;
	bh=ncuraEyF6SN14EfdNy/H9dVtgKftL38Jg5R4CeDtN9Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uswEK2tYoAmNXMmCDUU8FJeCZgpBEtfWkFB38uMgJ/oEGVGZICzirvetN3MXzp9MW
	 A82YrMOx30BKNjpb/o3tsVOpye37iHlxf6iU9eFpbLGYVNRKZHywYEUTRWIZEZTh13
	 ZknLmF1WiYpkSbw+s3CzfYXeHGrFoaYR7SSRbNsptTYmWM03/bOLioU2s18uF8/0v6
	 R85+YAZTVgediyxhkjHN3NLL/QIPRAkSOzmI4w3mvYi7TNlTkmY1L/RhueG+49eh1W
	 QhJfaxWZkyv89yzEgIAQxMlXFvBFpgt7tWQ2jq7l0KZuDBJ7k0mMddYJEeCc7ay1cc
	 xjg3NdmGfGeNw==
Date: Mon, 03 Mar 2025 04:05:54 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Aithal, Srikanth" <sraithal@amd.com>, "Xin Li (Intel)" <xin@zytor.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, will@kernel.org,
        peterz@infradead.org, yury.norov@gmail.com, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org, brgerst@gmail.com,
        andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_3/5=5D_x86/cpufeatures=3A_Generate?=
 =?US-ASCII?Q?_a_feature_mask_header_based_on_build_config?=
User-Agent: K-9 Mail for Android
In-Reply-To: <7c3b4623-45ea-4340-ac47-334071c1d15f@amd.com>
References: <20250228082338.73859-1-xin@zytor.com> <20250228082338.73859-4-xin@zytor.com> <7c3b4623-45ea-4340-ac47-334071c1d15f@amd.com>
Message-ID: <D03DAFD2-5EC9-4D16-BA66-FDA4B51F45DD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 3, 2025 3:38:05 AM PST, "Aithal, Srikanth" <sraithal@amd=2Ecom> wr=
ote:
>On 2/28/2025 1:53 PM, Xin Li (Intel) wrote:
>> From: "H=2E Peter Anvin (Intel)" <hpa@zytor=2Ecom>
>>=20
>> Introduce an AWK script to auto-generate a header with required and
>> disabled feature masks based on <asm/cpufeatures=2Eh> and current build
>> config=2E Thus for any CPU feature with a build config, e=2Eg=2E, X86_F=
RED,
>> simply add
>>=20
>> config X86_DISABLED_FEATURE_FRED
>> 	def_bool y
>> 	depends on !X86_FRED
>>=20
>> to arch/x86/Kconfig=2Ecpufeatures, instead of adding a conditional CPU
>> feature disable flag, e=2Eg=2E, DISABLE_FRED=2E
>>=20
>> Lastly the generated required and disabled feature masks will be added
>> to their corresponding feature masks for this particular compile-time
>> configuration=2E
>>=20
>> [ Xin: build integration improvements ]
>>=20
>> Signed-off-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>> Signed-off-by: Xin Li (Intel) <xin@zytor=2Ecom>
>> Reviewed-by: Nikolay Borisov <nik=2Eborisov@suse=2Ecom>
>> ---
>>=20
>> Change in v6:
>> * Make the AWK script work for mawk and BusyBox awk (Borislav Petkov)=
=2E
>>=20
>> Change in v5:
>> * More polishes (Nikolay Borisov)=2E
>>=20
>> Changes in v4:
>> * Add a few high-level comments to the AWK script (Nikolay Borisov)=2E
>> * Enforce CPU feature mask values to be unsigned=2E
>>=20
>> Changes in v3:
>> * Remove AWK code that generates extra debugging comments (Brian Gerst)=
=2E
>> * Move SSE_MASK to verify_cpu=2ES, the only place it is used (Brian Ger=
st)=2E
>>=20
>> Change in v2:
>> * Remove code generating unused macros {REQUIRED,DISABLED}_FEATURE(x)
>>    to tell if a CPU feature, e=2Eg=2E, X86_FEATURE_FRED, is a required =
or
>>    disabled feature for this particular compile-time configuration=2E
>> ---
>>   arch/x86/Makefile                  | 17 ++++++-
>>   arch/x86/boot/cpucheck=2Ec           |  3 +-
>>   arch/x86/boot/cpuflags=2Ec           |  1 -
>>   arch/x86/boot/mkcpustr=2Ec           |  3 +-
>>   arch/x86/include/asm/Kbuild        |  1 +
>>   arch/x86/include/asm/cpufeature=2Eh  |  1 +
>>   arch/x86/include/asm/cpufeatures=2Eh |  8 ---
>>   arch/x86/kernel/verify_cpu=2ES       |  4 ++
>>   arch/x86/tools/featuremasks=2Eawk    | 81 +++++++++++++++++++++++++++=
+++
>>   9 files changed, 105 insertions(+), 14 deletions(-)
>>   create mode 100755 arch/x86/tools/featuremasks=2Eawk
>>=20
>> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
>> index 6784129328f6=2E=2E60583987d320 100644
>> --- a/arch/x86/Makefile
>> +++ b/arch/x86/Makefile
>> @@ -263,9 +263,22 @@ archscripts: scripts_basic
>>   	$(Q)$(MAKE) $(build)=3Darch/x86/tools relocs
>>     ###
>> -# Syscall table generation
>> +# Feature masks header and syscall table generation
>>   -archheaders:
>> +out :=3D arch/x86/include/generated/asm
>> +featuremasks_hdr :=3D featuremasks=2Eh
>> +featuremasks_awk :=3D $(srctree)/arch/x86/tools/featuremasks=2Eawk
>> +cpufeatures_hdr :=3D $(srctree)/arch/x86/include/asm/cpufeatures=2Eh
>> +quiet_cmd_gen_featuremasks =3D GEN     $@
>> +      cmd_gen_featuremasks =3D $(AWK) -f $(featuremasks_awk) $(cpufeat=
ures_hdr) $(KCONFIG_CONFIG) > $@
>> +
>> +$(out)/$(featuremasks_hdr): $(featuremasks_awk) $(cpufeatures_hdr) $(K=
CONFIG_CONFIG) FORCE
>> +	$(shell mkdir -p $(out))
>> +	$(call if_changed,gen_featuremasks)
>> +
>> +targets +=3D $(out)/$(featuremasks_hdr)
>> +
>> +archheaders: $(out)/$(featuremasks_hdr)
>>   	$(Q)$(MAKE) $(build)=3Darch/x86/entry/syscalls all
>>     ###
>> diff --git a/arch/x86/boot/cpucheck=2Ec b/arch/x86/boot/cpucheck=2Ec
>> index 0aae4d4ed615=2E=2E8d03a741d1b2 100644
>> --- a/arch/x86/boot/cpucheck=2Ec
>> +++ b/arch/x86/boot/cpucheck=2Ec
>> @@ -22,10 +22,11 @@
>>   # include "boot=2Eh"
>>   #endif
>>   #include <linux/types=2Eh>
>> +#include <asm/featuremasks=2Eh>
>>   #include <asm/intel-family=2Eh>
>>   #include <asm/processor-flags=2Eh>
>> -#include <asm/required-features=2Eh>
>>   #include <asm/msr-index=2Eh>
>> +
>>   #include "string=2Eh"
>>   #include "msr=2Eh"
>>   diff --git a/arch/x86/boot/cpuflags=2Ec b/arch/x86/boot/cpuflags=2Ec
>> index d75237ba7ce9=2E=2E0cabdacb2a2f 100644
>> --- a/arch/x86/boot/cpuflags=2Ec
>> +++ b/arch/x86/boot/cpuflags=2Ec
>> @@ -3,7 +3,6 @@
>>   #include "bitops=2Eh"
>>     #include <asm/processor-flags=2Eh>
>> -#include <asm/required-features=2Eh>
>>   #include <asm/msr-index=2Eh>
>>   #include "cpuflags=2Eh"
>>   diff --git a/arch/x86/boot/mkcpustr=2Ec b/arch/x86/boot/mkcpustr=2Ec
>> index da0ccc5de538=2E=2Eb90110109675 100644
>> --- a/arch/x86/boot/mkcpustr=2Ec
>> +++ b/arch/x86/boot/mkcpustr=2Ec
>> @@ -12,8 +12,6 @@
>>     #include <stdio=2Eh>
>>   -#include "=2E=2E/include/asm/required-features=2Eh"
>> -#include "=2E=2E/include/asm/disabled-features=2Eh"
>>   #include "=2E=2E/include/asm/cpufeatures=2Eh"
>>   #include "=2E=2E/include/asm/vmxfeatures=2Eh"
>>   #include "=2E=2E/kernel/cpu/capflags=2Ec"
>> @@ -23,6 +21,7 @@ int main(void)
>>   	int i, j;
>>   	const char *str;
>>   +	printf("#include <asm/featuremasks=2Eh>\n\n");
>>   	printf("static const char x86_cap_strs[] =3D\n");
>>     	for (i =3D 0; i < NCAPINTS; i++) {
>> diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
>> index 58f4ddecc5fa=2E=2E51022d21003e 100644
>> --- a/arch/x86/include/asm/Kbuild
>> +++ b/arch/x86/include/asm/Kbuild
>> @@ -8,6 +8,7 @@ generated-y +=3D syscalls_x32=2Eh
>>   generated-y +=3D unistd_32_ia32=2Eh
>>   generated-y +=3D unistd_64_x32=2Eh
>>   generated-y +=3D xen-hypercalls=2Eh
>> +generated-y +=3D featuremasks=2Eh
>>     generic-y +=3D early_ioremap=2Eh
>>   generic-y +=3D fprobe=2Eh
>> diff --git a/arch/x86/include/asm/cpufeature=2Eh b/arch/x86/include/asm=
/cpufeature=2Eh
>> index de1ad09fe8d7=2E=2E077a5bbd1cc5 100644
>> --- a/arch/x86/include/asm/cpufeature=2Eh
>> +++ b/arch/x86/include/asm/cpufeature=2Eh
>> @@ -9,6 +9,7 @@
>>   #include <asm/asm=2Eh>
>>   #include <linux/bitops=2Eh>
>>   #include <asm/alternative=2Eh>
>> +#include <asm/featuremasks=2Eh>
>>     enum cpuid_leafs
>>   {
>> diff --git a/arch/x86/include/asm/cpufeatures=2Eh b/arch/x86/include/as=
m/cpufeatures=2Eh
>> index c8701abb7752=2E=2Eb9b7329f4ac4 100644
>> --- a/arch/x86/include/asm/cpufeatures=2Eh
>> +++ b/arch/x86/include/asm/cpufeatures=2Eh
>> @@ -2,14 +2,6 @@
>>   #ifndef _ASM_X86_CPUFEATURES_H
>>   #define _ASM_X86_CPUFEATURES_H
>>   -#ifndef _ASM_X86_REQUIRED_FEATURES_H
>> -#include <asm/required-features=2Eh>
>> -#endif
>> -
>> -#ifndef _ASM_X86_DISABLED_FEATURES_H
>> -#include <asm/disabled-features=2Eh>
>> -#endif
>> -
>>   /*
>>    * Defines x86 CPU feature bits
>>    */
>> diff --git a/arch/x86/kernel/verify_cpu=2ES b/arch/x86/kernel/verify_cp=
u=2ES
>> index 1258a5872d12=2E=2Ea23a65d5d177 100644
>> --- a/arch/x86/kernel/verify_cpu=2ES
>> +++ b/arch/x86/kernel/verify_cpu=2ES
>> @@ -29,8 +29,12 @@
>>    */
>>     #include <asm/cpufeatures=2Eh>
>> +#include <asm/featuremasks=2Eh>
>>   #include <asm/msr-index=2Eh>
>>   +#define SSE_MASK	\
>> +	(REQUIRED_MASK0 & ((1<<(X86_FEATURE_XMM & 31)) | (1<<(X86_FEATURE_XMM=
2 & 31))))
>> +
>>   SYM_FUNC_START_LOCAL(verify_cpu)
>>   	pushf				# Save caller passed flags
>>   	push	$0			# Kill any dangerous flags
>> diff --git a/arch/x86/tools/featuremasks=2Eawk b/arch/x86/tools/feature=
masks=2Eawk
>> new file mode 100755
>> index 000000000000=2E=2Efd3e72147157
>> --- /dev/null
>> +++ b/arch/x86/tools/featuremasks=2Eawk
>> @@ -0,0 +1,81 @@
>> +#!/usr/bin/awk
>> +#
>> +# Convert cpufeatures=2Eh to a list of compile-time masks
>> +# Note: this blithly assumes that each word has at least one
>> +# feature defined in it; if not, something else is wrong!
>> +#
>> +
>> +BEGIN {
>> +	printf "#ifndef _ASM_X86_FEATUREMASKS_H\n";
>> +	printf "#define _ASM_X86_FEATUREMASKS_H\n\n";
>> +
>> +	file =3D 0
>> +}
>> +
>> +FNR =3D=3D 1 {
>> +	++file;
>> +
>> +	# arch/x86/include/asm/cpufeatures=2Eh
>> +	if (file =3D=3D 1)
>> +		FS =3D "[ \t()*+]+";
>> +
>> +	# =2Econfig
>> +	if (file =3D=3D 2)
>> +		FS =3D "=3D";
>> +}
>> +
>> +# Create a dictionary of sorts, containing all defined feature bits
>> +file =3D=3D 1 && $1 ~ /^#define$/ && $2 ~ /^X86_FEATURE_/ {
>> +	nfeat =3D $3 * $4 + $5;
>> +	feat =3D $2;
>> +	sub(/^X86_FEATURE_/, "", feat);
>> +	feats[nfeat] =3D feat;
>> +}
>> +file =3D=3D 1 && $1 ~ /^#define$/ && $2 =3D=3D "NCAPINTS" {
>> +	ncapints =3D int($3);
>> +}
>> +
>> +# Create a dictionary featstat[REQUIRED|DISABLED, FEATURE_NAME] =3D on=
 | off
>> +file =3D=3D 2 && $1 ~ /^CONFIG_X86_(REQUIRED|DISABLED)_FEATURE_/ {
>> +	on =3D ($2 =3D=3D "y");
>> +	if (split($1, fs, "CONFIG_X86_|_FEATURE_") =3D=3D 3)
>> +		featstat[fs[2], fs[3]] =3D on;
>> +}
>> +
>> +END {
>> +	sets[1] =3D "REQUIRED";
>> +	sets[2] =3D "DISABLED";
>> +
>> +	for (ns in sets) {
>> +		s =3D sets[ns];
>> +
>> +		printf "/*\n";
>> +		printf " * %s features:\n", s;
>> +		printf " *\n";
>> +		fstr =3D "";
>> +		for (i =3D 0; i < ncapints; i++) {
>> +			mask =3D 0;
>> +			for (j =3D 0; j < 32; j++) {
>> +				feat =3D feats[i*32 + j];
>> +				if (featstat[s, feat]) {
>> +					nfstr =3D fstr " " feat;
>> +					if (length(nfstr) > 72) {
>> +						printf " *   %s\n", fstr;
>> +						nfstr =3D " " feat;
>> +					}
>> +					fstr =3D nfstr;
>> +					mask +=3D (2 ^ j);
>> +				}
>> +			}
>> +			masks[i] =3D mask;
>> +		}
>> +		printf " *   %s\n */\n", fstr;
>> +
>> +		for (i =3D 0; i < ncapints; i++)
>> +			printf "#define %s_MASK%d\t0x%08xU\n", s, i, masks[i];
>> +
>> +		printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS !=3D %d)\n\=
n", s, ncapints;
>> +	}
>> +
>> +	printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
>> +}
>
>
>
>Building kselftests is regressing with this commit on next-20250303=2E
>
># make headers
>  HOSTCC  scripts/basic/fixdep
>  HOSTCC  scripts/unifdef
>  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event=2Eh
>  WRAP    arch/x86/include/generated/uapi/asm/errno=2Eh
>  WRAP    arch/x86/include/generated/uapi/asm/fcntl=2Eh
>  WRAP    arch/x86/include/generated/uapi/asm/ioctl=2Eh
>  WRAP    arch/x86/include/generated/uapi/asm/ioctls=2Eh
>  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf=2Eh
>  WRAP    arch/x86/include/generated/uapi/asm/param=2Eh
>  WRAP    arch/x86/include/generated/uapi/asm/poll=2Eh
>  WRAP    arch/x86/include/generated/uapi/asm/resource=2Eh
>  WRAP    arch/x86/include/generated/uapi/asm/socket=2Eh
>  WRAP    arch/x86/include/generated/uapi/asm/sockios=2Eh
>  WRAP    arch/x86/include/generated/uapi/asm/termbits=2Eh
>  WRAP    arch/x86/include/generated/uapi/asm/termios=2Eh
>  WRAP    arch/x86/include/generated/uapi/asm/types=2Eh
>make[1]: *** No rule to make target '=2Econfig', needed by 'arch/x86/incl=
ude/generated/asm/featuremasks=2Eh'=2E  Stop=2E
>make: *** [Makefile:251: __sub-make] Error 2
>
>The same used to work fine until next-20250228=2E
>
>Recreation steps:
>1=2E Clone next-20250303
>2=2E make distclean
>3=2E make headers
>
>Srikanth Aithal <sraithal@amd=2Ecom>

"make headers" on an unconfigured tree should presumably only produce the =
uapi headers, not kernel-internal ones, one could surmise?
