Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E61957FC
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Oct 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759414406; cv=none; b=phP2RwmTOi/N3tJuqRiD6d+1kcBOfNtp5X58x4/fW7wuKK4ryRrfOGQLeZpewgCQXDTyUZLe2FEPnjWDm3AbSSkaHBSz3zECKll48UJHHBrHcoj6KM1ZA2ZckZkEkr///hZSENy9wdGfRnQIm8zgd2wGFcqt2wiN2Zvp3QnZqJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759414406; c=relaxed/simple;
	bh=NV6jcoPImgeJBzsOGuPk5KSxVvC7fxh2pZvRddlPPVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkF2xRO63qJAyW0hk8LffWn4c6NCiI9XSHijbDcIhm9qnK8xAZCo3TLzy3itjgErruLsOXjaEtDBj9ZrIENUsCul1d9LkoS/YtRF1kMJAf5xM0Af5+5YixiT1ZKGZzYe7rGVbQcn2Dlw5Xmg6gKJc/cJr+SVzBuNgM/OW32HZ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9iNFctG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9iNFctG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759414403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NV6jcoPImgeJBzsOGuPk5KSxVvC7fxh2pZvRddlPPVM=;
	b=h9iNFctGge/9e2oClv/DKKht7NaYRgSZilMpu5GfYIJNbtfnHGZXY3QF+reFmikZhUr3RC
	7/W2m/FglL4adw15ZFXMowCqBfEWavAzwoYbB3DOpd9YcxyK7i3JwxUV/tSOwfXmTaTL/Y
	oQbs5+j41nW2xjii7sn1X7DkvPWVW10=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-myolmK3VO-W2BpMnt3Axxw-1; Thu, 02 Oct 2025 10:13:22 -0400
X-MC-Unique: myolmK3VO-W2BpMnt3Axxw-1
X-Mimecast-MFC-AGG-ID: myolmK3VO-W2BpMnt3Axxw_1759414400
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-afcb7338319so133244366b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 07:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759414400; x=1760019200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NV6jcoPImgeJBzsOGuPk5KSxVvC7fxh2pZvRddlPPVM=;
        b=DBf4xX7FVIuff554Ln3794tkQv/KHyOYWra70//0Gs7cXQnQQY5CYgL51bFOU/3q+1
         E5p4C+J2JFufEgThYZEhbPPMsIL1KYAH9gaEXBRCEndYk1HDNzEyBO5CSLudUVlkB2T8
         833yn+6VPRtwz7Vpl/qjh+TXS++NDtgh3hxhs5Y2I4YHrOCqnpx72cX6wdmEWwD+UJ6v
         xcWND2RVW+e1/tnDYtU8OmRrzbtHhWYtZ24LgBHE0Yrwy1a55K2GfitggzfIxtMnTi+4
         qTaAryMO7bvlmppgDx/SMMnAsxgvQ4pUjwPIEPTh019JPWLGMRJtdSDFxVD6K7wxfxr9
         CJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqHQ0IXCrk+FMQjlyjwCOuizipBJ6Jk8VcwZhpcwqmpCB8yeWQ8PBM70Cb6C8mekof7Sv7iIBrP4fpa2hS88/R@vger.kernel.org
X-Gm-Message-State: AOJu0Yxih5fOPZkZKtS8dqWeIvm/SIBW5ucxuiHw0nv8kADjCFx79Z8E
	GTNSclCROgkIDrY+3guZHv9Igkt9opNE2lqONtJUoH2+WM6bDPJpnPyrM2vSBp56z8+GuEwbsXU
	imhjMCEAXK3+NCQbTrPcv4Cn9ekeXZh8dsYEX2YGuVmfNDr0m8ZA1qruuSdVETtdWYwbiNBzgT8
	/ClmCSdvB3pVBUnH+Lmu2t/9WoYkBiK9X8yzK1OQziQP7GUQ==
X-Gm-Gg: ASbGncuPWobESvMYMT7rTKzmVyme0qn4quK5PA0uCRT39yrmbgFvSfkNJ5awvTmUghC
	pZ509Em7qNr2yzt0RH36eih/4SvIR48W2AGTcxP7gG2A2e12vXAbedmgti1hUzfY2A3DubsXkDb
	VnCnDUAW4+X5rTleCOa2tTTyVf
X-Received: by 2002:a17:907:7fa3:b0:b3f:5513:5cd0 with SMTP id a640c23a62f3a-b46e2ff2dadmr931961966b.19.1759414400400;
        Thu, 02 Oct 2025 07:13:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXk+toomjEQdZBly5tWf6QhgCkT/IZoDzJRVf5J3LLN0uaDtazDg2BFzS/K2tcxfteSU5ooQZa3BalTHE+G+E=
X-Received: by 2002:a17:907:7fa3:b0:b3f:5513:5cd0 with SMTP id
 a640c23a62f3a-b46e2ff2dadmr931957666b.19.1759414399839; Thu, 02 Oct 2025
 07:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aN54leQ54ozcUXBO@x1>
In-Reply-To: <aN54leQ54ozcUXBO@x1>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 2 Oct 2025 16:13:09 +0200
X-Gm-Features: AS18NWBxssDHkYDSV9h-Nf_qnhtVRpYYBj6ckIuLN0oW3dgIwLK9xAm9KzX368A
Message-ID: <CAP4=nvSekQeTZvxLdajCp8FH2Xva1eN4=a8XhXODR9TMHKK3+w@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools build: Don't assume libtracefs-devel is always available
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Gabriele Monaco <gmonaco@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 2. 10. 2025 v 15:05 odes=C3=ADlatel Arnaldo Carvalho de Melo
<acme@kernel.org> napsal:
>
> perf doesn't use libtracefs and so it doesn't make sense to assume it is
> always available when building test-all.bin, defeating the feature check
> speedup it provides.
>
> The other tools/build/ users such as rtla, rv, etc call $(feature_check
> libtracefs) to check its availability instead of using the test-all.bin
> mechanism, stopping the build and asking for libtracefs-devel to be
> installed.
>
> Noticed after applying Ian Roger's removal unused libtracefs
> configuration in tools/perf/.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Gabriele Monaco <gmonaco@redhat.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tomas Glozar <tglozar@redhat.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Tomas Glozar <tglozar@redhat.com>

Perhaps it would also make sense to clarify in a comment that
test-all.c is to speed up perf build rather than rv, rtla etc. (which
don't use most of the dependencies listed there)?

Tomas

