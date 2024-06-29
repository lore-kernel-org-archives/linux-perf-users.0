Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3F136657;
	Sat, 29 Jun 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719685989; cv=none; b=deEZEI4z5YHCeXfqDtv0t8XZI57Ck6AqVXDaRPhKVDNgHEsJ92zE4Jxh3yfZpInOAvNKaTa1tpFnXntP0xOIGXoH5z02v2VhdYwu9hL80EmcEjL2i/CyVj5ih+PTIxXsYBQhI4xDN+/rWLyjiiXhUKvKTagjnakd2CY1CptoE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719685989; c=relaxed/simple;
	bh=LvwoJCao6F3nNuus2bjVRQ+rYqxO5B0hTZiTUTknFjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gywiLw3US0HNUB0wtJuESplBsJBvP8k8MUGrxzykYwR8JnaW3Mddmk2iU7YthnsS+CNOJqSIy3XzqOoHLh6zQ5FqGlgQl8bMFYP/Qyn0HpEPV95cLexhKrFrebrkV1jyzakW1X8IdfIK6UUzOBNktAExM2lxiAOwI8p1/+rnpRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ei+sD8MF; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ei+sD8MF"
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45TIWAO23565427
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 29 Jun 2024 11:32:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45TIWAO23565427
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719685932;
	bh=EQ2vMgmQ/iIonY8TFZZEf4+MUqUkNJ4xDoc19GNiIxs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ei+sD8MFKYWzgZscpEBrPr4YTSYBYuc6UsJVMnBIa7ccev7eGH4IkbEE0PmLvzk/F
	 wTqrUQ5i3sRzaQWuq4Qeetvda1nszVkcYqgGiUvGYRfVAYk/1sDRV66Ws4w2UAPxX1
	 k1duHCmlahn62oTf6RpovAUiwbYZxmrtvvNXbWK9C66kcWWO+Ir7eSkj0ZaO0nUlS4
	 f1Fn+aKkhJH/M3naWQtxRdcOug3IrTzF2evsIaqZJ+0vnBeHr148zkpGMtfa790B6y
	 6CJF05s8gpzcPj5q2Jm8KyDWY4hD/ps64mVY0jmKrE9u1+MYwJnslVKfjTmwv9HzJX
	 WyIotNhBfVUVA==
Message-ID: <a1d3b2dd-e4d0-4733-85a0-7d9f83c396a7@zytor.com>
Date: Sat, 29 Jun 2024 11:32:10 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] x86/irq: Define NMI source vectors
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        LKML
 <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Xin Li <xin3.li@intel.com>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>, acme@kernel.org,
        kan.liang@linux.intel.com, Andi Kleen <andi.kleen@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
 <20240628201839.673086-3-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240628201839.673086-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/2024 1:18 PM, Jacob Pan wrote:
> When NMI-source reporting is supported, each logical processor maintains
> a 16-bit NMI-source bitmap. It is up to the system software to assign NMI
> sources for their matching vector (bit position) in the bitmap.
> 
> Notice that NMI source vector is in a different namespace than the IDT
> vectors. Though they share the same programming interface/field in the
> NMI originator.
> 
> This initial allocation of the NMI sources are limited to local NMIs in
> that there is no external device NMI usage yet.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   arch/x86/include/asm/irq_vectors.h | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
> index 13aea8fc3d45..e4cd33bc4fef 100644
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -105,6 +105,34 @@
>   
>   #define NR_VECTORS			 256
>   
> +/*
> + * The NMI senders specify the NMI source vector as an 8bit integer in their

s/The NMI senders/NMI senders/

> + * vector field with NMI delivery mode. A local APIC receiving an NMI will
> + * set the corresponding bit in a 16bit bitmask, which is accumulated until
> + * the NMI is delivered.
> + * When a sender didn't specify an NMI source vector the source vector will
> + * be 0, which will result in bit 0 of the bitmask being set. For out of
> + * bounds vectors >= 16 bit 0 will also be set.
> + * When bit 0 is set, system software must invoke all registered NMI handlers
> + * as if NMI source feature is not enabled.

Add empty lines in the above paragraph.

> + *
> + * Vector 2 is reserved for matching IDT NMI vector where it may be hardcoded
> + * by some external devices.
> + *
> + * The NMI source vectors are sorted by descending priority with the exceptions
> + * of 0 and 2.
> + */
> +#define NMI_SOURCE_VEC_UNKNOWN		0
> +#define NMI_SOURCE_VEC_IPI_REBOOT	1	/* Crash reboot */
> +#define NMI_SOURCE_VEC_IDT_NMI		2	/* Match IDT NMI vector 2 */
> +#define NMI_SOURCE_VEC_IPI_SMP_STOP	3	/* Panic stop CPU */
> +#define NMI_SOURCE_VEC_IPI_BT		4	/* CPU backtrace */
> +#define NMI_SOURCE_VEC_PMI		5	/* PerfMon counters */
> +#define NMI_SOURCE_VEC_IPI_KGDB		6	/* KGDB */
> +#define NMI_SOURCE_VEC_IPI_MCE		7	/* MCE injection */
> +#define NMI_SOURCE_VEC_IPI_TEST		8	/* For remote and local IPIs */
> +#define NR_NMI_SOURCE_VECTORS		9

Fix alignment.

> +
>   #ifdef CONFIG_X86_LOCAL_APIC
>   #define FIRST_SYSTEM_VECTOR		POSTED_MSI_NOTIFICATION_VECTOR
>   #else

