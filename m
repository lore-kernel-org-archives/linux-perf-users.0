Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BC2525A77
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575708; cv=pass; b=MYe4H4yMsmhu0fMUDFi0O4+HCx4YzX+JOrrFKt7KuRWbiN/ui3H3i38eW4UT4tHO6drrYEgdYwNlcmmL3gUnsVfwfMyVq6vWMDbHWLS6OMSJeTH4R1p04fY00CO5zTVOPQGm1+Tez3n2JiXYRxUIPjZLE6I4muulURFv3SE9y/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575708; c=relaxed/simple;
	bh=xGqkw9om8wE25chq7Li5qakrkd3TSGUIudarLHsXZfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDn4jVHCpqcUucQvWUjGCjYucJEWT2JgP4ybsJbh5sflLN2c7Y0HMU3TOenVyDdolqgSwxEGn60Yx3wyeL5KzLbRiI8M5Tmq9prpws88jIvTGNXiIsU0OyhTMdX8SK+HfnTcdYZfrphunm3Clp5VB1KPNA+TNWspPpwERCx0BqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=zZN/0GsI; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="zZN/0GsI"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d43f9b119so11992247b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 09:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789575701; cv=none;
        d=google.com; s=arc-20260327;
        b=o1bY5W4n84xo8FRtT8HCdGkoO5OU8JnC5VFrKGyGKxGCpDRPgav+macy6xp5JR/Oas
         nyikysBcBcPpXvKQ7m9imY2MDb7cIjEiRWSBvuAec2RrDP5ToJm1eD+cEi5aY0DNUv7O
         CEFqY/MfdQmctl/MHQ+VFZX4TxDlEm5jRMZm9mUn7i3OPo2zrCdE2oBReE5jpWxW4OVE
         9yzZOo6RfAZQDxYtzBmzeOfTGDY6MdW7ls87xqju5nV+T8MJubUAZbc4gBvyQQyVIEHi
         DMXrcHzbWOYx50r9NiwWxsAS49QaHPbyCzgqB7eLxXYwRz9KtAswag2PG1nehUirTbjm
         lhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xGqkw9om8wE25chq7Li5qakrkd3TSGUIudarLHsXZfQ=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=evXuH0BtPQj26KALnMMZYbUFqsLmHmFi8U5If3xXvnp9R5CNl3zEkFjDyBjKSg4VhF
         RqkNpb+IqE1aZtUtecLCWiv3oAJwBtuoJXVJrFIG6o+skjEFAH9HASJyqr8813y3i0Yu
         eoOVveUPI9i7sZHDSesCnsQ4LxrZor3haokxcjFiGKEytjXIFWf3U0QPzRvV7VRGVeQN
         4+h0noD3u7OX9UpIoh3Rwnm4V4+JQfUzVMd7Q+yHcZR+Xs6QnaMTBVL2KWqXbmrM+Ruc
         8lIiPgOrDDnUxYXG2qznUGBG75pNorvH9NlwMNBAZ5gyma6HFFY5McJiZKR57BOPqreO
         TFMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1789575701; x=1790180501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xGqkw9om8wE25chq7Li5qakrkd3TSGUIudarLHsXZfQ=;
        b=zZN/0GsIbfPzbR5ww8cxEBriRv87TAuVqZi49o0gY32wF9VPxDwqWefSp4Y30FMuuV
         TLB9cpV6hegD6UO8qlluMAF2XQLsTeH7Bx93aJqQIZtqwH5OBmqLVRqpvbb7BSGlRWbU
         /uH2AfkpPSeUDOTXtAOM+JGaYAhM9h/pLdxgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575701; x=1790180501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xGqkw9om8wE25chq7Li5qakrkd3TSGUIudarLHsXZfQ=;
        b=0RBNB4sTd0IjiYoJ0i59W5V07F1h4JV1V9RdkqFHsU3+asJkkTzOi5PAwoBVl42o4C
         9qXKdth/jbKPiJ8AqafFF5BCK9yHFOBf0SjuqorT6POSS/CcYYFbM7DEklbqz82dsPUm
         C1ov1D4+I9mgNlOCSZ5MMt0ee7N/SkeRyP9PQzmA3ESopQKQevSN4kc6JNUxGUPinWLf
         GiOeihhycBVhmpmN8Cp1Cc7dgE7TXwtLV1bGPeMTe+D2hXtzg7YARXxJwrZD+iroaSnB
         FvP5XXtAp2AawuBdlRTRT1SMRHpD5+nENy4DZRfHoEKriY8kxOP5qZ2Fiwuk6UqMhtlM
         8NLQ==
X-Gm-Message-State: AFuF++nyDB31qUn9LKyr2oCDoqwdcM4AZcC+TWj31Vvb52l1zsppDcll
	41OmK1jhmTice+KvEFytDBmF7sW06C21W2plJqPCKliASV5jgwruGS/QRgzB4GZ7MGxJjTjJe7e
	+i8wFC/pq5jJevG19X+muatDrPedmJ2XF1MtR+RF2AbBnLTDNLfplTbtFHw==
X-Gm-Gg: AYBFou2kJGi4ZEKNpi2NxhhINJbxp2JVXUQUR4Mg7Ad0VKCEYvi+YhVL2xYl28S77gp
	0A5s/DmNhCboc1IawrOWOg4Mt/Gt6JhbrmDLBLSkAyoP1CBOSbu40ramboUJCt3QswVObo5Cmk0
	dvtRW5eUC549xDxVtq1dbU4zOCIzFUnmS4/tMRCgzMBeC+kbRQjV29xbfxIHHGA5fEpb/GHL0Cx
	INk1kD+m32rDBZB6NkWtigAyY56RNWqmFTpPt9azbOa+/HaJ77uLAgYnPshiaOyoFpOWRvs/rIc
	uqR6a81YLlEv7Qh2uAQ20kYLaOjhVeTECEB173obD4TVDi6CcKi32fhouhDeH3tLd+d7C6eCsn1
	eIafD29bMWEA=
X-Received: by 2002:a05:690c:c4e5:b0:883:2240:7dab with SMTP id
 00721157ae682-892207626f4mr11820137b3.4.1789575700451; Wed, 16 Sep 2026
 09:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
 <20260915-perf-symbol-memory-send-v1-4-1d3360e21f07@uber.com> <20260915185035.2D7591F00893@smtp.kernel.org>
In-Reply-To: <20260915185035.2D7591F00893@smtp.kernel.org>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Wed, 16 Sep 2026 09:21:23 -0700
X-Gm-Features: AcwNN1VdYcZEyvR19ibW-s9HakT46aBZmfAoGbi-EsThjlJWIoi2un2PXZsR2aY
Message-ID: <CA+w=M=T61XoscNet+teD+Dr72GvyfbL-+=2-+0c-JK=rjQmrjA@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf script: Document and test --lazy-load-symbols
 and --max-symbol-bytes
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] perf test: missing err=3D2 assignments cause skips to be repor=
ted as success
> - [Medium] perf test: strict byte comparison fails on platforms with diff=
ering debug output
> --

Thanks, both findings are valid. I=E2=80=99ll make the skip paths return
status 2 without overriding a prior failure, and narrow the
eager-versus-lazy comparison to the controlled test symbol rather than
comparing all output from every DSO. I=E2=80=99ll include these fixes in v2=
.
