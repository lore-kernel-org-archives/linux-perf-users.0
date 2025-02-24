Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2635949;
	Mon, 24 Feb 2025 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740382279; cv=none; b=YXp81VjfkwdIQqARXyBB62ylYgu9t1eHGdlf1niBw6h67xLE0Luk6Urnbd7NfinsZADjobD2w9Q3xMwbRKY8DA2uQwsoXVowZycVCb+a9wVnZFJXH1WLPoqQFk7UpsJT39aEKsf6P5LHUjtNB5w0L/WKVxhpSMW99P93XJvWfTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740382279; c=relaxed/simple;
	bh=6Vux+9H8ClY2pt6ERsaHUcicqiz2Ducfgs2C7k+Rxw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYjTQNgFYRSEjjC4hwtrzD3KovMeyoSIx2OCSIIVIAIyiSpZU9Pr2CAdFdNylx39zlQFqFpuNEHq4ESsO/27GRCweXgKAeo2I1/rmq1+oFYmux58PGb+vzEgJ0ADD51VE1ucshTMF2xVv1/g0EcgKrFZ/0QVQj+AjkJOSkSLqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=AsMt3S/Q; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AsMt3S/Q"
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51O7UL3h542569
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 23 Feb 2025 23:30:22 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51O7UL3h542569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740382223;
	bh=TeiLPSpazN8lCJ+dY5HZXFK2ebNNvqeFBMhxstgbSoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AsMt3S/QCcp4YqmtHt2CLr9mFhZdPLKPfYGWnZWAeyYpW+49DCYSWdOGlFb92fml0
	 G3nrkrG1TkKZtowCnVP5tvKTC36kgXSLPF799IOwFKWIZzwZ1TqzkVPuPk1kyhlXG4
	 6cCondFoQuo7uAOT/J8EqHc3cizxlWDCT4tLjCzgkEO/OKtDAqS5ofwl0NGj408DrS
	 Z47FSQAGmgrtgn85yfAPo9VgrnaKzXMF7Qzwimn1FpBANCU8sl5SRfTa3U0Dr/MAra
	 PW6cRW26S5wijW5Q5aRXchpRol6BvRYlT4ZvpEupHdRCw5xq9/Us5x9ctV5cgNtNyk
	 nl0hYnNEW3hrg==
Message-ID: <52bf4850-b66c-4692-8827-8995793607c3@zytor.com>
Date: Sun, 23 Feb 2025 23:30:21 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] x86/cpufeatures: Add the CPU feature bit for MSR
 immediate form instructions
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org, peterz@infradead.org,
        yury.norov@gmail.com, akpm@linux-foundation.org, acme@kernel.org,
        namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com,
        nik.borisov@suse.com
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250106070727.3211006-6-xin@zytor.com>
 <20250222163001.GUZ7n7iRc88PTMQi9_@fat_crate.local>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250222163001.GUZ7n7iRc88PTMQi9_@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/2025 8:30 AM, Borislav Petkov wrote:
> On Sun, Jan 05, 2025 at 11:07:27PM -0800, Xin Li (Intel) wrote:
>> The immediate form of MSR access instructions are primarily motivated by
>> performance, not code size: by having the MSR number in an immediate, it
>> is available *much* earlier in the pipeline, which allows the hardware
>> much more leeway about how a particular MSR is handled.
>>
>> Add a new CPU feature word for CPUID.7.1.ECX and then the CPU feature bit
>> for MSR immediate form.
> 
> Nope, scattered.c.

Oh, neat.

>> @@ -476,6 +476,9 @@
>>   #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
>>   #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
>>   
>> +/* Intel-defined CPU features, CPUID level 0x00000007:1 (ECX), word 22 */
>> +#define X86_FEATURE_MSR_IMM		(22*32+ 5) /* "msr_imm" MSR immediate form instructions */
> 
> Also no "msr_imm": Documentation/arch/x86/cpuinfo.rst

My bad.

> 
> In any case, this patch doesn't belong in this set.
> 

Right.

I tried to show that we don't need to make the following changes due to
NCAPINTS increased to 23 if this patch is based on this patch set.

But if this feature is added through scattered.c, NCAPINTS is not even
changed...

Thanks!
     Xin

---
diff --git a/arch/x86/include/asm/cpufeature.h 
b/arch/x86/include/asm/cpufeature.h
index de1ad09fe8d7..051d006cc0c6 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -95,7 +96,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
            CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||    \
            CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 21, feature_bit) ||    \
            REQUIRED_MASK_CHECK                                    ||    \
-          BUILD_BUG_ON_ZERO(NCAPINTS != 22))
+          BUILD_BUG_ON_ZERO(NCAPINTS != 23))

  #define DISABLED_MASK_BIT_SET(feature_bit)                             \
          ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||    \
@@ -121,7 +122,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
            CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||    \
            CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 21, feature_bit) ||    \
            DISABLED_MASK_CHECK                                    ||    \
-          BUILD_BUG_ON_ZERO(NCAPINTS != 22))
+          BUILD_BUG_ON_ZERO(NCAPINTS != 23))

  #define cpu_has(c, bit) 
         \
         (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :  \
diff --git a/arch/x86/include/asm/disabled-features.h 
b/arch/x86/include/asm/disabled-features.h
index c492bdc97b05..c6a1f962185c 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -156,6 +156,6 @@
  #define DISABLED_MASK19        (DISABLE_SEV_SNP)
  #define DISABLED_MASK20        0
  #define DISABLED_MASK21        0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 23)

  #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/required-features.h 
b/arch/x86/include/asm/required-features.h
index e9187ddd3d1f..a346db1d078c 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -100,6 +100,6 @@
  #define REQUIRED_MASK19        0
  #define REQUIRED_MASK20        0
  #define REQUIRED_MASK21        0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 23)

  #endif /* _ASM_X86_REQUIRED_FEATURES_H */


