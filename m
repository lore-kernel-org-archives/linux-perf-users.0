Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA24A1B;
	Wed, 12 Jun 2024 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718160657; cv=none; b=I7ec1iRCHCVrZNQdF6w+7Kg2V3RORRJODjOpP9vG3fafbQat6Vgs8LPg0NgBqOTNPC9pF8X8Te3mDHZ4hIbpAJxn4I58F9ACohJUyB/rmj0UMXnqD6ts8zSY+Dw6P7noIUE2UEkLsYO9fyURuFxxEgJAEJqcmbo6sFsD/itqHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718160657; c=relaxed/simple;
	bh=zTGmkn9RYqniLIoUDeQLAzkmq3vSg0xcjBLCRnqFJMU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iTfGvUR3igf0/Qpq26H7qOtdzjnSnEki44l66tHfAym25QpddRrvWfuKQDL2aVcgp2KMHBlIWWY4Wn8PzXVE7hZwJaJN3i4mOKUBES1jdpV/W/7hq6VzqI+pPX6NuAynKUY06b/BtJu+Nar0PuEeB0QNOOjSAroVlgZgUzPuXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=TzEwFfzS; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TzEwFfzS"
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45C2oOL13580510
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Jun 2024 19:50:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45C2oOL13580510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718160625;
	bh=jEMINHR38VIasVMcGmedrlItZN2lOReLRTxa7jG/SIQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=TzEwFfzS/BmSZUQCUnORkFM0JdHO2Q8VoFSrV6NAOB0Of4iWU2Wc4yOfAoehRqBdY
	 Uwo9miu15DprE3OgoO9s3zgUXgLjsIibentLqHvPGRrLMWjJYlwlNHQ2FJDsgbjPBC
	 I69202B0dAtYzrM6vAAuWI7GuLcqOShCWkLIbNWcAy1qzFT5UOHDJ2ehgKM81C9xVD
	 0RCXTK5BDE84VqCnhwEjvptUNnnPulOxln+t3abKmRyyNxAv3OHED6HQ9f8EDDTgWD
	 SEyWdAm+vJjI4SWEmLM+gVX3+VoIHtMW9cTnIjyvkDFekt5IVu4ZPsSTsdDj4UPYLf
	 GvvXAXCSgXrSg==
Date: Tue, 11 Jun 2024 19:50:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
CC: Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/6=5D_x86/irq=3A_Add_enumera?=
 =?US-ASCII?Q?tion_of_NMI_source_reporting_CPU_feature?=
User-Agent: K-9 Mail for Android
In-Reply-To: <de99f490-8b8d-4ae9-9f87-e0336e563aba@zytor.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com> <20240611165457.156364-2-jacob.jun.pan@linux.intel.com> <de99f490-8b8d-4ae9-9f87-e0336e563aba@zytor.com>
Message-ID: <34E0974A-45E0-4E98-9384-3A19D01ECF1E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 11, 2024 7:32:54 PM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 6/11/2024 9:54 AM, Jacob Pan wrote:
>> The lack of a mechanism to pinpoint the origins of Non-Maskable Interru=
pts
>> (NMIs) necessitates that the NMI vector 2 handler consults each NMI sou=
rce
>> handler individually=2E This approach leads to inefficiencies, delays, =
and
>> the occurrence of unnecessary NMIs, thereby also constraining the poten=
tial
>> applications of NMIs=2E
>>=20
>> A new CPU feature, known as NMI source reporting, has been introduced a=
s
>> part of the Flexible Return and Event Delivery (FRED) spec=2E This feat=
ure
>> enables the NMI vector 2 handler to directly obtain information about t=
he
>> NMI source from the FRED event data=2E
>>=20
>> The functionality of NMI source reporting is tied to the FRED=2E Althou=
gh it
>> is enumerated by a unique CPUID feature bit, it cannot be turned off
>> independently once FRED is activated=2E
>>=20
>> Signed-off-by: Jacob Pan <jacob=2Ejun=2Epan@linux=2Eintel=2Ecom>
>> ---
>> v2: Removed NMI source from static CPU ID dependency table (HPA)
>> ---
>>   arch/x86/Kconfig                         | 9 +++++++++
>>   arch/x86/include/asm/cpufeatures=2Eh       | 1 +
>>   arch/x86/include/asm/disabled-features=2Eh | 8 +++++++-
>>   arch/x86/kernel/traps=2Ec                  | 4 +++-
>>   4 files changed, 20 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 1d7122a1883e=2E=2Eb8b15f20b94e 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -511,12 +511,21 @@ config X86_CPU_RESCTRL
>>   config X86_FRED
>>   	bool "Flexible Return and Event Delivery"
>>   	depends on X86_64
>> +	select X86_NMI_SOURCE
>>   	help
>>   	  When enabled, try to use Flexible Return and Event Delivery
>>   	  instead of the legacy SYSCALL/SYSENTER/IDT architecture for
>>   	  ring transitions and exception/interrupt handling if the
>>   	  system supports it=2E
>>   +config X86_NMI_SOURCE
>
>Lets reuse X86_FRED instead of adding another hard config option=2E See
>below=2E
>
>> +	def_bool n
>> +	help
>> +	  Once enabled, information on NMI originator/source can be provided
>> +	  via FRED event data=2E This makes NMI processing more efficient in =
that
>> +	  NMI handler does not need to check for every possible source at
>> +	  runtime when NMI is delivered=2E
>> +
>>   config X86_BIGSMP
>>   	bool "Support for big SMP systems with more than 8 CPUs"
>>   	depends on SMP && X86_32
>
>=2E=2E=2E
>
>> diff --git a/arch/x86/include/asm/disabled-features=2Eh b/arch/x86/incl=
ude/asm/disabled-features=2Eh
>> index c492bdc97b05=2E=2E3856c4737d65 100644
>> --- a/arch/x86/include/asm/disabled-features=2Eh
>> +++ b/arch/x86/include/asm/disabled-features=2Eh
>> @@ -123,6 +123,12 @@
>>   # define DISABLE_FRED	(1 << (X86_FEATURE_FRED & 31))
>>   #endif
>>   +#ifdef CONFIG_X86_NMI_SOURCE
>> +# define DISABLE_NMI_SOURCE	0
>> +#else
>> +# define DISABLE_NMI_SOURCE	(1 << (X86_FEATURE_NMI_SOURCE & 31))
>> +#endif
>> +
>>   #ifdef CONFIG_KVM_AMD_SEV
>>   #define DISABLE_SEV_SNP		0
>>   #else
>> @@ -145,7 +151,7 @@
>>   #define DISABLED_MASK10	0
>>   #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UN=
RET| \
>>   			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
>> -#define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
>> +#define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM|DISABLE_NMI_SOURCE)
>>   #define DISABLED_MASK13	0
>>   #define DISABLED_MASK14	0
>>   #define DISABLED_MASK15	0
>> diff --git a/arch/x86/kernel/traps=2Ec b/arch/x86/kernel/traps=2Ec
>> index 4fa0b17e5043=2E=2E465f04e4a79f 100644
>> --- a/arch/x86/kernel/traps=2Ec
>> +++ b/arch/x86/kernel/traps=2Ec
>> @@ -1427,8 +1427,10 @@ early_param("fred", fred_setup);
>>     void __init trap_init(void)
>>   {
>> -	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred)
>> +	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred) {
>>   		setup_clear_cpu_cap(X86_FEATURE_FRED);
>> +		setup_clear_cpu_cap(X86_FEATURE_NMI_SOURCE);
>> +	}
>
>With this, no need to add DISABLE_NMI_SOURCE to disabled-features=2Eh:
>
>1) If FRED is not available, NMI source won't be too=2E
>2) If FRED is available but not enabled, all features relying on FRED
>should be cleared=2E We probably should move the feature bits clearing
>code into a static function when more such features are added in future=
=2E
>
>>     	/* Init cpu_entry_area before IST entries are set up */
>>   	setup_cpu_entry_areas();
>
>Thanks!
>    Xin

And even if we did, FRED should not *select* NMI_SOURCE; the dependency go=
es the other way=2E
