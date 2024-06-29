Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C586116;
	Sat, 29 Jun 2024 00:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719621407; cv=none; b=n6QAWYH+K5FQO6lOjDQJbCC/J9hs+An1fbsUIh7w2p1KdUl4srkhm3SNX/vs5wxsHu7XgPXtBxx6B4GMYihfUGEzSdjTz5xW+q/nkWrofqLCYoOIV7KEh675ijrNHaDCVhky3YOI9dQvAK8wJ4MybOT2TiTDwytQ+nWMVQFYqMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719621407; c=relaxed/simple;
	bh=OAHxOy7oiRw6lYj/c7KQNQLmxlYTjZEAxFRAaNqB2LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsUSOFYER7P4NSeY4i6KJSt7uJympuIyjX/beeA+BtA9lZnOCN9pXqiKYi05FXyiP02OAbxeT2PZSgZvQHVD21ejxWJb5OHiN5nqsoPWwPrpEdOsdk3e2wpGwbSYA1uUMv2U4UTPapiwawH1362fpuNy7A5wTXxAoZTozKhBtNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Qx0b7g0K; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Qx0b7g0K"
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45T0Vo8s3236504
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 28 Jun 2024 17:31:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45T0Vo8s3236504
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719621112;
	bh=xOzbYQQ3RGnYupUc8UIfDVYfD8nwN2PODU9sbh5z8Tc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qx0b7g0KFIeCH5UcmzgZYhNOR02eDgR+KAaehkh+wu8Mw+xIRpnIoAQWev3LfLHvV
	 M6q3dXtpHpZXSodFaINpHdeznuMCdD2SluQQsGVSWDm/xkjzkQejf436Fn1qneTZDX
	 zNEZ4XRjKhZBdkEKQaHJo0Gv7C8fGAXfrsSwfX+T6q8nn4CMrOx3A2hEWo/3GtZI7F
	 HkEfmU/SrAlM29/bW6Z9D4uaxc4vYZ4Kig7sTUNBj7iCGA6wCT3touzPeUJYJOUPDj
	 Ko2NlEwRbvDuHBugHBr3em498h+bQyDWiMv4Q9w7QNJlZYIKzv+FQlADNQgrjQT8F0
	 eQsxICJJI2B8g==
Message-ID: <889c06bc-6577-4fac-b61e-b2d30e99bbfb@zytor.com>
Date: Fri, 28 Jun 2024 17:31:50 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] x86/irq: Factor out common NMI handling code
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
 <20240628201839.673086-5-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240628201839.673086-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/2024 1:18 PM, Jacob Pan wrote:
> In preparation for handling NMIs with explicit source reporting, factor
> out common code for reuse.
> 

My read is that this patch has no functional change, right?

If yes, please add "No functional change intended."

> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   arch/x86/kernel/nmi.c | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 1ebe93edba7a..639a34e78bc9 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -135,6 +135,20 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration)
>   		action->handler, duration, decimal_msecs);
>   }
>   
> +static inline int do_handle_nmi(struct nmiaction *a, struct pt_regs *regs, unsigned int type)
> +{
> +	int thishandled;
> +	u64 delta;
> +
> +	delta = sched_clock();
> +	thishandled = a->handler(type, regs);
> +	delta = sched_clock() - delta;
> +	trace_nmi_handler(a->handler, (int)delta, thishandled);
> +	nmi_check_duration(a, delta);
> +
> +	return thishandled;
> +}
> +
>   static int nmi_handle(unsigned int type, struct pt_regs *regs)
>   {
>   	struct nmi_desc *desc = nmi_to_desc(type);
> @@ -149,18 +163,8 @@ static int nmi_handle(unsigned int type, struct pt_regs *regs)
>   	 * can be latched at any given time.  Walk the whole list
>   	 * to handle those situations.
>   	 */
> -	list_for_each_entry_rcu(a, &desc->head, list) {
> -		int thishandled;
> -		u64 delta;
> -
> -		delta = sched_clock();
> -		thishandled = a->handler(type, regs);
> -		handled += thishandled;
> -		delta = sched_clock() - delta;
> -		trace_nmi_handler(a->handler, (int)delta, thishandled);
> -
> -		nmi_check_duration(a, delta);
> -	}
> +	list_for_each_entry_rcu(a, &desc->head, list)
> +		handled += do_handle_nmi(a, regs, type);
>   
>   	rcu_read_unlock();
>   

As this is a preparation patch, better move it earlier before any actual 
NMI source changes, maybe the first patch of this series.

Thanks!
     Xin
