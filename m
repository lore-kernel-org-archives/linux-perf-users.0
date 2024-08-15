Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603E43ABD
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2024 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748508; cv=none; b=VHCOW8wxE2XRhPZKXiHQM39mZItv3cGXCTq0Kduo2iEKk6VKywoLKs5Mrgj/EoPbsGhjThzxr+NUeGCJkmJQgn2yFPtBmX1kfaOHZ0AzWOr73+Mohfe6fycXZ3D8Ruhd0ucR2uowB/xs9jLrN5gVnwhK4v8JBdeRnjUktN1cJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748508; c=relaxed/simple;
	bh=Ia56IaP2wCwdztFSxen90kn9phtOnuIPt4qP/ILHOxY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KQpX95yUnFuhGRBD7l9qrBONMEtJT09EG/ckLrowUPAo/o8nwXqywnfauntz4Uur60sa60mp4jQ/F6jTRL+hY6txTfDwNgetGGA961VXfjd10jC/5PykidJAt7uzKyVd6pzbTrmytbh4iXw4rfE0GmRCf14dDd2Sy7KmCmo7XmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=Mpth+/mL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="Mpth+/mL"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a50313f785so49192685a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2024 12:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1723748505; x=1724353305; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYoHgaX6Oh7hOJvjP6bYFuodoCT3Q3xdPz+YF6JrpLs=;
        b=Mpth+/mLeUrKJd363gmizhIkMCfuRkYlST56Eyac8PT6rSfGrJTeIlSpw8b3/riV8H
         e7pGdm/3UvdNWMMZ7cAdkLApEK3eyz4+dwjfdYNvODTojXQ9HKt35nBrlVuKGoSpoaWR
         x22uH/pxq9H8NCiUWgABh+xNs9SWq6W6hHuao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723748505; x=1724353305;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYoHgaX6Oh7hOJvjP6bYFuodoCT3Q3xdPz+YF6JrpLs=;
        b=cTZyPGIT+KHgZtvabvxZAcw5OZrwXd9hwj4glwGPQWId4b1JCkoZFdsFy4OAmJKCAt
         U3DLCnkOskwlUUXEFXdok4MQYrYxkfJq4+CfKMfs6qvfRb/xLBMKUwr2RKyLQuafEO6e
         Z5ndM4YZR1gqGnnGk27+aGtxcxAuSYJo9Mtr71Ci3csFVo9AbNs5VDBO/B0r+lDcBZsf
         hyJjL5KlfA+Ht3FncUVDDfu5YISz68n7WsVifP5QFdtxMITwWJcnI9qF+GjSex6zrXly
         J5jDXkOC4rZM6zb1g1RIBPtdBdOtw+V2NHMVfYx9tyV7LVPZYGkpsmXUPsuJITNLuL5P
         anXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsUO359AiJ/ab1NzexiC7pgCS+nNcmqoQCeW8VAL2n55j5GKuwlepILnzkvhqgbpnFKWVh9ajQutSgr5u++VsaoLNr+kGAEueN3bKo3PunLg==
X-Gm-Message-State: AOJu0YxrqRaGXAww59bDSJ3MCFxbZFirE6gLjUfCzNIZovYad+sYqJZ4
	NMLz9wNEzWvrxyOIjXLhBQu6dwHej2Mgb8PoYCopqP31B30c6G/Kp8bUMg8Cbw==
X-Google-Smtp-Source: AGHT+IEczJIMuzRH/O6ERN1btYguU3GnudkhPvvJqeqlDMQz09wFIySHt/aagHTo2ffLCUAepQ4Vpw==
X-Received: by 2002:a05:620a:4142:b0:7a1:c3e8:121 with SMTP id af79cd13be357-7a5069ec304mr80655785a.57.1723748505324;
        Thu, 15 Aug 2024 12:01:45 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff1073b4sm88597385a.104.2024.08.15.12.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 12:01:44 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Thu, 15 Aug 2024 15:01:42 -0400 (EDT)
To: "Liang, Kan" <kan.liang@linux.intel.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Li Huafei <lihuafei1@huawei.com>, 
    peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
    namhyung@kernel.org, mark.rutland@arm.com, 
    alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
    adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com, 
    x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
    Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH] perf/x86/intel: Restrict period on Haswell
In-Reply-To: <166fdbdf-b24d-4267-b42d-f11348b87b1b@linux.intel.com>
Message-ID: <201991b2-d77a-c10f-d46d-ee9b34ba11e5@maine.edu>
References: <87sev7nom4.ffs@tglx> <a42a3e35-2166-4539-930b-21ea0921e8d8@linux.intel.com> <87frr7nd28.ffs@tglx> <70657c5e-f771-456b-a5ac-3df590249288@linux.intel.com> <875xs2oh69.ffs@tglx> <166fdbdf-b24d-4267-b42d-f11348b87b1b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 Aug 2024, Liang, Kan wrote:

> I also found a related discussion about 9 years ago.
> https://lore.kernel.org/lkml/alpine.DEB.2.11.1505181343090.32481@vincent-weaver-1.umelst.maine.edu/
> Vince tried the workaround but it seems not work.
> 
> So limiting the min period of the fixed counter 0 to 32 seems the only
> workaround for now.

I'm actually still lurking on this discussion.  My regular fuzzing machine 
is still a Haswell machine (the same one from 9 years ago) and it reliably 
hits this issue within hours.  I hadn't realized there was an official 
reproducer.

If a patch does come out of this I'll be glad to test it.

Vince Weaver
vincent.weaver@maine.edu
