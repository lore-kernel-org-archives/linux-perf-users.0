Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCA2F39A2
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765580345; cv=none; b=O7gFGATd/QYX0RoYs3D12UXoTFbW0q0cuxarxpBjn38m4XsW56Ws85QHEL0q+qxOLuJSQ5Y2aOXMCd/QdE0GYMtm8r9Kku+dFfvolFgnp4VBVZ+TjzziqKvmFCzZLEBu3evtTvhQGxm1bGebPRWM9Z/T49syRrenfxbP+SpsIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765580345; c=relaxed/simple;
	bh=7bslInIBLJIoLn/9TutWUpr69eWhQhXaLvHEGWAesY0=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=i0yUMUNbQjCJL+71RB63OdZ/mtPU7tJgyQIj+W8XU4puwD40UGiFGvmtWLnPqh9v3ge+7eulXgd4j61x7ktwOm8mKgAlZUEeVc+DUBDOIdyxVjMqug0BBrQBG6lwEVm54xpK34zKGmKipJ8NUH0Imr7/VbexnXygT3NL6GYkEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jVYH8cYG; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jVYH8cYG"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7c6d917f184so1423878a34.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 14:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765580343; x=1766185143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tBFcNzGChK01MBl7aRFxeqVQzmaQvoTyGJMrwZXP/1Q=;
        b=jVYH8cYGDRhUhxifgajdZOsToCsIevvKQcPuHJqgeqiyM6J4bSKk0BbDSMvTeavxYF
         46v35BE3mzyUckBVDyX+t6bFc8DQNE8G+5vaX9HSWEXgmXpuLsMilxVI5KQw7r1PUo0p
         4+LO92YfEjdn8YqVDLcsrUATartyXsX/jv/3ZD6lOzAevAUxCE+EVLg7QWkenEan6MqD
         9t4HbQyC7yg2YTsc7Kx2uww4W4M1PUdkSL33bN6hRwFbPnAzU5dNB3wCeu+7UftOKj4A
         /YGInhe8GfSUS4xpKoTEb36c4TvW1doFr4iEHeC3nMEiTR0zqs7zcsAXaYloao3f7CPH
         W6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765580343; x=1766185143;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBFcNzGChK01MBl7aRFxeqVQzmaQvoTyGJMrwZXP/1Q=;
        b=sxMNL4fVXmhVuDp9EAgUBHju7WAHLrzTwvARD2XnJAdXcibihYPGX7UnWp0uPzMA8T
         PIo2vWJ2xEMd2TmszwLkn2quKmmpX5dPbBNLJnQ65LTFcOJB40TTDThCsm8HuLOxtSH4
         6qoPV5NWb1E7nRG23Ss8Rmy3mpQtJQGSx83Ytf53zH2boO5kbU9kN5x1y1yM0WON5pO5
         P3ErlSz8CZ9FEQQNnlFUW/u7VpGPOwOp2iy9w7erSjR3mWflKD2xV7FvRglLUpSx1V5R
         w8lSvjVUBUwOMS9GxwG3h5hW1A6hD3g5aF5Ld/veLzFaalht2CSTl5Frm8/P/U/ZRab+
         NutA==
X-Forwarded-Encrypted: i=1; AJvYcCX5lZk2vb+KHZD4N018sQ1NCAQm3vo2+qjFilV9Fjq8WmvZ535VS4nImmC4GHFPceNcuTS5x0F5gjrys3MUyZcB@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdjgKTN5z4Btl+xLJzZ09Y9Dei5QcT9WQU4ZuyZeNuqM78HQ7
	X7PFYrrVVstYx0iE4eA4OvrKJLMH8Hb1rK3cbiOtRXr1d0S76tm1s5lBIGEqE3lQguRl+hCdVFt
	atJ+TePGYVv6lGJ3Vr9WXevvhng==
X-Google-Smtp-Source: AGHT+IErW9ttpylPAKTVb6sUEZwG4YGY35EKiSdiqsCWGntNWnLEEqDhx+071F1DfXt8IYeJCob+cCIIDVfcvHekjQ==
X-Received: from ilbbc25.prod.google.com ([2002:a05:6e02:99:b0:434:972f:bf92])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:1886:b0:65b:35a2:7a8b with SMTP id 006d021491bc7-65b4523911emr1339446eaf.82.1765580342788;
 Fri, 12 Dec 2025 14:59:02 -0800 (PST)
Date: Fri, 12 Dec 2025 22:59:01 +0000
In-Reply-To: <aTipeb2fAmUtSzzX@kernel.org> (message from Oliver Upton on Tue,
 9 Dec 2025 14:58:01 -0800)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt5xab2toq.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 22/24] KVM: arm64: Add KVM_CAP to partition the PMU
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oupton@kernel.org>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oupton@kernel.org> writes:

> On Tue, Dec 09, 2025 at 08:51:19PM +0000, Colton Lewis wrote:
>> +
>> +7.245 KVM_CAP_ARM_PARTITION_PMU
>> +-------------------------------------
>> +

> Why can't this be a vCPU attribute similar to the other vPMU controls?
> Making the UAPI consistent will make it easier for userspace to reason
> about it.

I'm confused by the inconsistency of using a vCPU attribute for
something we want to affect the whole VM.

But I'll do a vCPU attribute if you want.

> Better yet, we could make the UAPI such that userspace selects a PMU
> implementation and the partitioned-ness of the PMU at the same time.

Sounds good.

>> @@ -132,6 +134,16 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>>   		}
>>   		mutex_unlock(&kvm->lock);
>>   		break;
>> +	case KVM_CAP_ARM_PARTITION_PMU:
>> +		if (kvm->created_vcpus) {
>> +			r = -EBUSY;
>> +		} else if (!kvm_pmu_partition_ready()) {
>> +			r = -EPERM;
>> +		} else {
>> +			r = 0;
>> +			kvm_pmu_partition_enable(kvm, cap->args[0]);
>> +		}
>> +		break;
>>   	default:
>>   		break;
>>   	}
>> @@ -388,6 +400,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm,  
>> long ext)
>>   	case KVM_CAP_ARM_PMU_V3:
>>   		r = kvm_supports_guest_pmuv3();
>>   		break;
>> +	case KVM_CAP_ARM_PARTITION_PMU:
>> +		r = kvm_pmu_partition_ready();

> "ready" is very confusing in this context, as KVM will never be ready to
> support the feature on a system w/o the prerequisites.

That was a last minute addition. I'll change the name to something
better.

> Thanks,
> Oliver
