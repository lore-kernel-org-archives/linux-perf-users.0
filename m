Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D06D2AF11
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381889; cv=none; b=SiuVa+FjZhYIs8yzgfu7ZT3crjTSxR0hHFiP6yjUE6DOd+9Ghwm/gO0I9JVBGq5Dvr8sDrrlB5h4OEtRR5Pz2ndHwIx0oANjC3JItq3nyQkLSmISqOuFTXrCJsiRNdFffjcMTheqa1+FwVzx49Fj45azelzcRgXz8xeKs3/mwXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381889; c=relaxed/simple;
	bh=QCJD0mQOiMjnGuAJudaL7EcJbEt4EzgBOz8VC0vUBAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAM/Mh29tEXxBZUw63h7A2jGNcQ+9uraIZjjdUTkyXAzpMVMda30bnxZXTB4RGBqcvb/haWbNKSi0ilbsJioNqXxy9jmRJxxJPdgrDaqqvbVkARD3/ghbihL8OyYpWNbgokikIKOdA86y2tcfwKtl/GsUAiidDLNe6nCoD6APUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=L3X8FZOr; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L3X8FZOr"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eede876fcbso19236171fa.2
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721381885; x=1721986685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHuQOzwZHF/RNpfChTvHFJsWi3ick1N/VEEIytMiyeQ=;
        b=L3X8FZOr1oTZ+1GEgFIL8xhA9re52AgE6Qz/RmZlOudm0TpQN2t2AZJ5n+/bFlPaCP
         vBJOmEIHrxRdEY443F2p52oyPgQZjzZbwpiz4e8UrSoKdiNGIdgKNJ8KieOiHRTlrpKd
         i82YJUgIzF319AIKeT3bhK7gi0Lft1HIUAAIpQMlJU1aQlHV2NbHyuhY5goctPQjslrK
         GHppjlOnB0DQRn65D6vfqGa6TxGUlz2C/vm1w8co4l52EwTtWbQKZX2ah/6i0ETbVzXE
         y92L4N69mpSWv9tK1pPIoGGyJj9qvqa+K8k77LjvsBl7DXT1rVkACkS7CXJiIC+N/LfU
         CFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721381885; x=1721986685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHuQOzwZHF/RNpfChTvHFJsWi3ick1N/VEEIytMiyeQ=;
        b=VLIR8WucJUUslj8CnzUIIrTsWiolYgalKvWGEc7bW+R92/6Q/f3ptcNnWy2ck58Gjz
         wNM2/1lS40mKd09JLwCKwuzgL1+nvmtRsmGn4dSw0z9EFp86D65TxkETHbucdtJ+Doc2
         XZP2qvgAQKbE6mff1CQ5ortgWcb/9C341QVW7XlOg380lcsz+HLOUb/BDF19YR9GAWwL
         NEW1VBrqlE4iCX1TBT37f2R//CcVZPPEPwtG2HBGuiGve/KqStFq1hMm4ovpdacHqN4y
         HjcfzNN59jP6+kbRE97tkY5q+wO6yg3DgLJpFx/IJ1yl/UpyeRBgYLw1TSQErX9IIIYD
         QR0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIyQ5b09IjjBCQnQ41OXM/DBCnR1AEIzh4rMJZ6Q6+0Z86Gtw0YbtXTHSvgrLS3lOkIZhKXV2vrfwrAhpfPovnHU1MQe97api20vtJYgtbiw==
X-Gm-Message-State: AOJu0YyfgNZhpsEwian6Yktdwht3ukiCRDP7G96pWonak1So8IwWTD+R
	nm2KokynuqPJH1l9tM0QuQiT7hqSO1IJhsoKxWxSBtX7GQ0kBezda6fx8iajzEbnb3BfqPExdr0
	gShd+Tyyy6KZtnS1k+DmCVUWi8beMn/oTe9Mhsg==
X-Google-Smtp-Source: AGHT+IGiJNTRWlBgnX41CQFZmILGxpV1J9kBUt1OoMxruvBGLdHaDWwzwf0eXsqOE/wPqccfZTwogeTX0F7BgSX59RM=
X-Received: by 2002:a2e:a17b:0:b0:2ec:596c:b629 with SMTP id
 38308e7fff4ca-2ef05c726bbmr33287691fa.20.1721381885303; Fri, 19 Jul 2024
 02:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718152254.16007-1-eric.lin@sifive.com> <12bd744ea481c8a3505e6f4869d409d24d3db795.camel@maquefel.me>
In-Reply-To: <12bd744ea481c8a3505e6f4869d409d24d3db795.camel@maquefel.me>
From: Eric Lin <eric.lin@sifive.com>
Date: Fri, 19 Jul 2024 17:37:53 +0800
Message-ID: <CAPqJEFp+KHku2ygaHhv0YP3Wy1RhuKOZ33EAonzaUxxkM5z-Fg@mail.gmail.com>
Subject: Re: [PATCH] perf arch events: Fix duplicate RISC-V SBI firmware event name
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, aou@eecs.berkeley.edu, 
	dminus@andestech.com, inochiama@outlook.com, irogers@google.com, 
	jisheng.teoh@starfivetech.com, jolsa@kernel.org, kan.liang@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, locus84@andestech.com, mark.rutland@arm.com, 
	mingo@redhat.com, n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com, 
	peterlin@andestech.com, peterz@infradead.org, samuel.holland@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nikita,

On Fri, Jul 19, 2024 at 4:51=E2=80=AFPM Nikita Shubin <nikita.shubin@maquef=
el.me> wrote:
>
> Hi Eric,
>
> Nice catch!
>
> Shouldn't it fix every patch that copied affected 'firmware.json' by
> the way ?
>
> Something like:
>
> Fixes: 8f0dcb4e7364 ("perf arch events: riscv sbi firmware std event
> files")
> Fixes: c4f769d4093d ("perf vendor events riscv: add Sifive U74 JSON
> file")
> Fixes: acbf6de674ef ("perf vendor events riscv: Add StarFive Dubhe-80
> JSON file")
> Fixes: 7340c6df49df ("perf vendor events riscv: add T-HEAD C9xx JSON
> file")
> Fixes: f5102e31c209 ("riscv: andes: Support specifying symbolic
> firmware and hardware raw event")
>
> Reviewed-by: Nikita Shubin <n.shubin@yadro.com>


OK, I'll add every patch "Fixes:"  in the commit message and send the v2 pa=
tch.
Thanks for the review.

Regards,
Eric Lin
