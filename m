Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793037109;
	b=S2h/CSfSpjaD2+bbFIIILHlanUKIrJSkkb465ymL7ZPQOQxRUtsJyQ0vZ6Fha5WvzkqX
	 je/Onc2hVeir3WcC/FfO3E+BU+yYUTdsmnzT43zNMUDY2yeFyCe05RWPPrzKtsT84QDgH
	 EBxGAWGMXwxe+E1EcNJ8HCEfRHTFg+eiL7R/yGv41+BEqGZOSUE4iYxu3KfsSPG0g8uT3
	 ZjdyGbT/cCVK3ZCUqLtrJ6+G2NAHoZYtZWFw3Sr8liOOpH9GH2Q1pfEyyXb2CTZfob4hm
	 C3lUpfgnHy/ykALVmUCnnCyOoIW8IeCYyd8Uymim5Q+oGjIiImGtiPRKzbIHWRGUnSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=x5IoPxKCD6gSAuyfPampTFdrhWai9Fe21YmZghCUFXg=;
	b=JT2EzjDjxAXdDtlSc82MWwUcVG0m/LNdWbPm4bY/ANKWz2OD84JkAXeddr1kUyPQgcAJ
	 QmRS4y+TjcnbUP+eOm4DGEbRH2LULEcAV0Fex9xHfUkYrWWMUXDWlCC8oMqnGW3kFMTxM
	 stUqksx4Gfx/xVLcK3ypbyjDmqVG/sOqfp8Gcr03aw02BZbLKtTsuSsqCVkD8Rki5sBze
	 5posstgPxyvEfENayljrTsiKzyFChp1qu8sHU6kubFGCbFFRb88QyTwvdRsAXQkQiXz++
	 GaWRUr5S56oCTa1vUnfTRHewgJNDvlsowGRUVjcuEyPSDv3nJsbSwbKy/F2W9umfeqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PLrFlcyt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEAA606A323
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 17:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FEAA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PLrFlcyt
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so1262a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 10:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793037107; cv=none;
        d=google.com; s=arc-20260327;
        b=ZbTfLN+yJbclg7ap0e2bHamTllVRMGJg0JFoXX/SvuR9RY1CFGmpqHbItiD2Cz3SMx
         U2HFaye3qPLBUgeBYxGhhAGgO86EM+pXBsMsf8TmGB/cpDqKD64dUfota+HDfPgR8ABk
         HNfHtxe4OMLN1IT4akD+5eLO8gkdksvbqn+C0KONiYclczzxbVQiR6+QlDb8y9g9rKVk
         EDanz0LmVmKVqzXFXMlhjSzit2mKJUst0RugmCsvBFgKxOGUGc+97jr0mfarW6hG/DPt
         VQRJ6AV8f4knXy/D6EIjGde8GabSEydpY8eFLEXJ3qS4XVqQIZltWRT83Ws+NNrz4d8m
         H0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x5IoPxKCD6gSAuyfPampTFdrhWai9Fe21YmZghCUFXg=;
        fh=WTl/0O1s0PnoXzmt96tcuoCVtAd6NUp9uTk/F+RFZ5Y=;
        b=Uzzg49/JJgDLp/CO3e9LIbYpaWzBNfstrj7qeaCzmvUxyaeB0vAKRuSq/bV4+ynqnx
         uzKywRo3ttKhUvbIpt8By1VOh25Q9Io9IZh4/dw0EW1O8SJI7tAqQ5ZIv5RnHaxO1Bv6
         3YQTANeCaCKuW5J5V7OxeFcyJBucCfUa/xuVueDOnad58/D6Oy8p4J9+M874js2WxwO/
         kWeBknQxwXUgwuqeouZiGnmmVn67/YXtooyPfQKzt1afSxvVz1AAQH3z1d84lIIDjPOS
         3MumGDNMsSZ61xYuSGen08yshjj5VrnegiqjabScNVjS/SiI7GRLO51Vc2G0Pd9yjL1B
         BIag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793037107; x=1793641907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x5IoPxKCD6gSAuyfPampTFdrhWai9Fe21YmZghCUFXg=;
        b=PLrFlcytHLhsfFUTWuDHcrUInlXtdj+Bn8sw4p/4CVQcjYe8HCudqWvzQ6wsbPYSP0
         K9b95dZ4gs6sUyI5I0vvSs0yEs5ttR+r65Oy63q/A0Rxrs/BYZ/115wxKJIhvPzM81D0
         M76oShiHIWiE1YehZaPK7d5w5d2Ra1+iGvQZEyasiDrZQkeIMKbH7a2744pEAsN7CNeg
         4DTzhijonK/RwDggd0T2MS6Mq6zY8Vdj/kD1OWigfQZsX5F3JiYv7EBIFWoam7Vge9bB
         bsiJQZeAfm7jTYb9LY0egWFKv70DHny3bb8/MGACF8IDPYC9yGa+5SUYxNWaVLEVQJQ/
         xcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793037107; x=1793641907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x5IoPxKCD6gSAuyfPampTFdrhWai9Fe21YmZghCUFXg=;
        b=KJA05UoqNlDA1ajtMK4FQsSsnQ8sOdlWWvlWZRd/Bq29C8wHOseOoAvfjiGXELyjU+
         4ZT6l4BrejXQTzO4PhAoMlmbd6vsmZtnzcnqKoNi6AlVYDRm9Ixre+dsA4Rxdfm5SJhE
         AIfQVhRRHR7rpDhU9MDoG/1VZmAwgzGzrho/h+lqevgoqm58hLqndeL0s76spGiCdpb/
         pSQTNKCAZ3ij+oXCvhqBqOsL6h6LuXn13tANgzLbDuIo9k3Z1UwyxO3bheodBVnMEcRC
         MxrEFTNK9VBlv8Ue9uPZ2jyCPoGPyKuDELts0IperscCC7Q9M++2LPZtGz+2cHVZmaDH
         htNA==
X-Forwarded-Encrypted: i=1; AKwUvByNHNBJz8pzRYaZ7lHpn7yDsvcEuduM1/dn80PirWlhtUGsifTf+BpPOndejQhuwmHpSzzTkOuovmeAa+9OhC+A@vger.kernel.org
X-Gm-Message-State: AFq9FYJcRM/RrvJ4h30Nuf9U1B+zRPL1k5oYuOSfamcaBWjmJL1uCNsI
	3w8Mx/TixbqYFhU4EuH1qVIVrwI/IEcK5y+im2M2B7O4f44qJPukGP9cXQTreHS2Wd8YbrG7Ck7
	zrHjhOYjOLvNimJZgt3OzcEnvPsqEdlVZzkCv2fSk
X-Gm-Gg: AYBFou1kim1cCOkBgoHfXOuE3bQriwnJYQoYOozryKjjNxzXZH+WWvv7inYS0586frX
	etj6H99h2AIzMoAFgBmklvuZl+uJ+2Qay+QAjHa1ushhqs4JpDekfHDhq5gYHFszDP1Q2AXe6Uy
	L15qzrVeuxpwwr78kzTcw7pTXIO+munWq3uHtV/FWP6ORcfN36kaVgTbxNK+7QKXf7+boj1jyM2
	gdRWViBdHxPHsQQCDUAkE04ENPsK5+rGzo4u+TJM6zIRpVYpryZ43z5/dkcH3yOxbKnXwuWgKu8
	yZdT7Fk4oQKXU6pnEHVU+2dBhjkrCvGludQUEfmKVYrsOUvLxA6GZNPy1w6m3mdnPVTzZITlvFv
	NFFgJff9fDiiSPzcH8cxfECQJG2/qkD+pQp/zKQ==
X-Received: by 2002:a05:6402:486:b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6b47c31cd5bmr1422a12.10.1793037107029; Mon, 26 Oct 2026
 10:51:47 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026041838.941-1-ravi.bangoria@amd.com> <20261026041838.941-3-ravi.bangoria@amd.com>
In-Reply-To: <20261026041838.941-3-ravi.bangoria@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 26 Oct 2026 10:51:34 -0700
X-Gm-Features: AclHuK8ntyEgwPTHmatXufpHpq3GjNdwMAlW9fpSt7ft02yt5TrTtwxApDC3KgE
Message-ID: <CALMp9eRMNVHMtbN1U+X7Cdi0hvvY1nHZPf-kPZtFP62ND3jmsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf/amd/ibs: Fix kernel address leak via
 REGS_USER and REGS_INTR
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Jayapal Ashwin Nair <janair@amd.com>, Gennady Kupava <gennady.kupava@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Manali Shukla <manali.shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 9:19=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> IBS hardware captures a sample and raises an NMI. Since the NMI can be
> delivered with a delay, a privilege change may occur between sample
> capture and NMI delivery. Because IBS only provides the sample RIP, the
> kernel records GPRs from the NMI pt_regs, which may reflect kernel mode
> if a privilege switch occurred in the interim. This can leak kernel
> addresses to unprivileged users through PERF_SAMPLE_REGS_USER and/or
> PERF_SAMPLE_REGS_INTR.
>
> Fix this by using interrupt regs while preparing PERF_SAMPLE_REGS_USER
> and PERF_SAMPLE_REGS_INTR. With the change, when IBS samples a user mode
> instruction but the NMI is delivered in kernel mode, PERF_SAMPLE_REGS_USE=
R
> will source its register state from task_pt_regs(current) and
> PERF_SAMPLE_REGS_INTR will be omitted from the data sent to userspace.
>
> In addition to fixing the kernel address leak, this change also ensures
> GPR snapshot consistency, which resolves the DWARF unwinding issue with
> IBS.
>
> Reported-by: Gennady Kupava <gennady.kupava@gmail.com>
> Closes: https://lore.kernel.org/r/CAPu-DQqF0aF6=3DGS8Z6KKWeeX_V5LiXeKU_rJ=
QZC+uGg8zuTPNw@mail.gmail.com
> Reported-by: Jayapal Ashwin Nair <janair@amd.com>
> Fixes: d29e744c7167 ("perf/x86: Relax privilege filter restriction on AMD=
 IBS")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
