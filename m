Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E23A4513
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827188; cv=pass; b=R/wTjSJtQKpuV64WcpU/pPHZZJg+55LUThIJG4lbKJXfJjde9WmZ9ezkKzrMrE07JyAnbRncYzCWMPxNwmc7Qq6LlfChqyFDzTVifKJksaP6YJNWm2lA7ByNn2kLjSuuQup1l+ihKJTek1wO0DV+TAc0TG943ymBlUjIPqkTeuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827188; c=relaxed/simple;
	bh=c6Jgg/grfysHpxHwrZUQ5iCcEDSIAVzCSJdujGu2d9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=oUp0rtMCvnMK6qWT4l4qqohlhv7XslCbEERiELQI9eoscTG7MbGUHYza/lPSkFLFCay2/Ug2NLZ41THFycojePPKIK86kMPSveQFBXN8HLKmUoj//xIymqoNhdsEypJxzP8WMHN9ivm4a3cFiPGxYMl+MRXFJQDUof8ziDfJYfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5wevTNp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qHmMcbj+; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5wevTNp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qHmMcbj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775827186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6Jgg/grfysHpxHwrZUQ5iCcEDSIAVzCSJdujGu2d9Q=;
	b=i5wevTNpdgiD35rH/wP5QTtXZoceoh8bjUTePYpIYnm1LJrmLHTTO9xSfdAbiW1AfmbuDS
	GX3COXP3pxo+1ngEPTyTQetnEYMAi8/a41JBmDHB9Y2oAF8myxOZZQYSY9AQKb+c8GfSmF
	eOwQf224KetcYKpdWHIPV8tNJZSirKk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-O5biFcBBM3O0wtFcrDkvZw-1; Fri, 10 Apr 2026 09:19:45 -0400
X-MC-Unique: O5biFcBBM3O0wtFcrDkvZw-1
X-Mimecast-MFC-AGG-ID: O5biFcBBM3O0wtFcrDkvZw_1775827183
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-59e16c11f49so1832959e87.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 06:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775827182; cv=none;
        d=google.com; s=arc-20240605;
        b=csRWsGm617MrTE43gNW6T2g9o5UWCZLaIktX5bkLUALnbK/eEDiqW5bHtgS6oPpdOH
         F/sKgyqwsknS/zPdokhak3Uo7TnWWWOkKt3t1aX++ANQqldRphJtdNZ22I6QVfee1jtn
         lGpw35CZ3TchLCs9E9WP2OehtVO3Xkhv1h6HCVu70Ndt8QKdzgbSbOCU/1N8/S1VnbSY
         0WtwH5cRnDEgh9ZH2at6YpQRZZlMuw0+Y+/iBgz7N+DIGf/KVjNWNN68aNzk8I4WS2lf
         +PH8kvJ53n/uKKIaK74Y2l5BRqBvbhxDQqS0kYUfxhHqoCOfIq4rhK1Y55dfAMNMgyI4
         3VYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c6Jgg/grfysHpxHwrZUQ5iCcEDSIAVzCSJdujGu2d9Q=;
        fh=gIcXGLotfzO2ZmnEhSjFNq+ft2UaQ90WGwRr7ybmEa4=;
        b=X9FLLvweDQP8HscZhQREMN0CMb6y3Hvphpf9ay0ZL+h7RxnqMynqXZS4HVy7yQenyw
         JPw0yZznVyfxzjCYJ/y/gz2fWfcNLSiDZVX7qDelVcYSf5/xfb55/4XnsS6ibyXWSkrt
         7Xkwi6u4DcKYKf0uAPWFJv9Hrz9NYESpVuhU9v41qndsR0eSaAK/Gvhz/S0bzmoYINUU
         iluFJjbrLb4j/4VXpBLCNVLhA6e77jTOqLUDMNCi2NuqWbRK6XzjIb6UQx41gAhdKPI7
         zmLJ0IBVrW7qQTX6IvQWoLs3Q5eikNThKY1cvOoD8WgfSvMd8zcvid7x4UoBPmyGuQAE
         n0Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775827182; x=1776431982; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6Jgg/grfysHpxHwrZUQ5iCcEDSIAVzCSJdujGu2d9Q=;
        b=qHmMcbj+5A44XuIKsdMKOHrW/v4mk5SrVYYsdXnyHUDw1ZBzUOP555TTAdH23kU3UI
         WJxFy9hIYQN1pQ6N97HjcEg3tFgbas7Y8L9kv3meb3K/qw3RqgmLasv/SWoItHaLuKPo
         AGRXlHnnCoWquzs5MW6AEebpo1Q/9mx8XIiqf1Jc5gUm34imC4vr8T0Z2CI/orpneEzV
         xaJYt4jyRh1z+h1Mvd7FwIcV3oLuTgHDl6zH7Ym467fBPZoNKXcyUw9I9vyEy+O4D7/N
         9PYKeq2DYrdsWw8djIanbNeIxNUfZfL6RSSFiCvM02V4xQAOkjpfceO0/sO8I0FSl7OV
         +MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775827182; x=1776431982;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c6Jgg/grfysHpxHwrZUQ5iCcEDSIAVzCSJdujGu2d9Q=;
        b=U38YCHTGOc1FQaX41D6VXXL6WxzmP54GhczinlOe+QFPUNR6WFD3niebYIi3J8EUNb
         IXub8LJk3CKf1Lvi0dml2WHToPiPnNfwc5yegWHolJgTkxWbiJGtsb+KgK8l7Md4fXb7
         BblQ4/7r31n2A71VJCzZk6vQqeu+eHK6IJMbw4ZF/TKr9IERLsHGxlgS0vk5/pwSUUrK
         aaLMicSFfs+k0vTCAy5kzZ06tgh30ivSOq0TPa55ZBqUOR+nCBnJ4u4JMe1DCE+vG5M/
         1E9xqYZcHKn4vliAbCGpA46jB6x2RFt+a/ir2k+aaB+lNMokhepA1ti1yVOcXM9moagM
         dp5g==
X-Gm-Message-State: AOJu0YwY7Ur3Ii7WlFDoPluIBEajBoQNkxvhowT5VBOpi6idaQNV4g+r
	99sFGl7h5z6U/Jb+M6ZKemknh3z5h0gclFL2bDKNy873n/cDNpKlth9ROCXOy5MY03v7LgOVPEz
	DADuc26F8F1+NQjMwO3lFFLk/0FnDDoP8bxEjk6oNLOfW70Im36xJfQ18uBcwzPDWj1IjLC3/A/
	d2WXB188cEkAt1TCa0Qh87KlncXuc9PLxub7XhIFpMASzDmGLDszf5Lw==
X-Gm-Gg: AeBDievXXf3MNwZQkgZp0Lqcm0cfeHz7x1EKWfPGL/kq2u1bpeVG3gmHHrgtTRR9B8o
	mSgOuIhjHLMf29GW1ysJXjGm8+/9rGB8w2KCccVqpgPd5JIvSvVk4BbD5PRNc1S+IGSpCwG9xSh
	cM7lowD0D1Mw0x2q8fmQ5MWcz2vy97UfjdviV25wE0m6QFe9xCXIX1DYp0VrX+K8WhYe2+kDQAa
	2ur8ONxa5nFmXthf8yRdO3pYd/Neq3AXJg=
X-Received: by 2002:a05:6512:1596:b0:5a2:b51a:6a55 with SMTP id 2adb3069b0e04-5a3efb4178cmr1065497e87.29.1775827182387;
        Fri, 10 Apr 2026 06:19:42 -0700 (PDT)
X-Received: by 2002:a05:6512:1596:b0:5a2:b51a:6a55 with SMTP id
 2adb3069b0e04-5a3efb4178cmr1065485e87.29.1775827181791; Fri, 10 Apr 2026
 06:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408123947.23779-2-ashelat@redhat.com> <20260408130630.EB302C19421@smtp.kernel.org>
In-Reply-To: <20260408130630.EB302C19421@smtp.kernel.org>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Fri, 10 Apr 2026 09:19:28 -0400
X-Gm-Features: AQROBzC9kZdi6at7gBFBjcWztyKOAls2O2g-ll9S1U2fFlwYLHpMFoo-Xf_P2BM
Message-ID: <CA+G8DhKz-=CJkU6Hh66iO_R9rhg7OpJThnABT+HKa_FY50_OTQ@mail.gmail.com>
Subject: Re: [PATCH] perf: enable unprivileged syscall tracing with perf trace
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 9:11=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [Critical] Bypassing `perf_allow_kernel()` for task-attached tracepoint=
s allows unprivileged users to leak kernel registers, instruction pointers,=
 and callchains, completely defeating KASLR.
This makes sense, I'll send a v2 patch to fix this.

> - [Medium] The change to make the tracefs 'id' and 'format' files world-r=
eadable is functionally ineffective for unprivileged users due to restricti=
ve parent directory permissions.
Some systems have /sys/kernel/tracefs mounted as 0755 so this change
handles those systems.

