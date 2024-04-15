Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115BB155A27
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209462; cv=none; b=TjQJtIYwF9Y4xWjSCl3q7Rq/HITGsZYWbGuE/PNQ2PzhqIqGQS3ajEcu161uda+Cdo2i2hky40tzma+5MivX0ncN24C/LJ95WcHVSJCSEF4TyR5G9y+eRMLPnvEMiby9EQ3R1CbB/oTsDlC35+BSFJG/wXjI9m9ogBJH2Y0c6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209462; c=relaxed/simple;
	bh=lxbmyU0k/X65fHyfg3gSRRK0UijDeoQsO7+COxuWGxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=K9doFA6e7olREveDybrNT3yQ/0MsXsbGndbLPg1OxPm/l+GMMYjZg0/74jcf44UGEQ3vCoTKFiVpx2fYosr4uHKWjy16LXsvfbjEX2tjbLeGu9d9SSL3j/LFipnOvT7Tb9EwHRzRrgRBr62ZftcLJjV8HW8sV48MV4LhoEejCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUmifPMi; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUmifPMi"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-233f389a61eso1450153fac.3
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 12:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713209460; x=1713814260; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxbmyU0k/X65fHyfg3gSRRK0UijDeoQsO7+COxuWGxA=;
        b=BUmifPMivrCgRzQxUif8SeAg5efVJ+C3Pjp6NLwJqTpt9Ed8GiuZT46xKu52azM9Ow
         HmkGk8UWvEh3rZqz4YatEspj1XaVffah0aAWpkqicvrWwUmDz9GJ2WOL+f++uaFFmjfv
         ah/Y3+GKhe1Lmq5Fe6td/LHg5hj/eSEHaXlnvh+ykbEAuJnZ9TnduBl1hOZSp3roS9KW
         QsPcfd3A2uj6z+gagqPUn/DFaSbzp5fPA+fJ0tDAkK/Oe7jLh141GnlJrIqHPr72uZaX
         eoOUmuUTZSp9UdTXgH5cihM+IARwvQSgnn8G9IUMnNFrKDMDjLujfarzKET62fKFGj30
         M7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209460; x=1713814260;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxbmyU0k/X65fHyfg3gSRRK0UijDeoQsO7+COxuWGxA=;
        b=MqSg58e7QTiQXEY0RkZXY9UmF0pll/qWsry1xmkC1GWe9jhPaJiA5L71Xclt4ANKAU
         Ki27ZInWglhF39sQ2Cb0cBVHpw4R3lHVg5rAEWAjMv9GZ9L/i+Kl6sdEyRtgcQYJyAea
         9I37qL2xiB/JPBpFxRJKPe2eT+eANBtuTLDfFJowaMgsyRnUWnlDZRu+USYR34gx+1N8
         zTNzlqqawYZMYSvoY4KlCgTirSN36rNjHGzfZj/puYZqmtsiCT9/0dnpHL45pM0De9Ha
         n6e5wq5CJ5uICpSpvMuyLAjip2FGZyPxzj6M+gMdeC0bhWaK62N657ezGDDjF32C72cj
         3W2w==
X-Gm-Message-State: AOJu0Yx1QUIQvXRAMkE1uKB/mvs+a+onom9NLxczi2m43y4kKXZqDVbT
	H1eO55vUDFnVy20cTyUZHFoEfpfa31ZCMH6LlMyk/Z5Ft4LkXDp8f3JAv+5xzEAkpJ67q4PdVsg
	hJRDIoVtORM/jhFMHVVLP3gLvJS+N7wz9
X-Google-Smtp-Source: AGHT+IHA6cJzQ9/JZ81LXxo4skP/M4lebRZCP1NaWTLd0obuMWl8TegyOCqHJhCQMCtikS7aTIHXAmQB0U8F0IgY5Kg=
X-Received: by 2002:a05:6871:58f:b0:22e:96a0:201c with SMTP id
 u15-20020a056871058f00b0022e96a0201cmr11880649oan.35.1713209459924; Mon, 15
 Apr 2024 12:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+phaecbKJXE56ExeJUA5c2=tc3m3p8iNefuqyjs9P3kOn_aWg@mail.gmail.com>
In-Reply-To: <CA+phaecbKJXE56ExeJUA5c2=tc3m3p8iNefuqyjs9P3kOn_aWg@mail.gmail.com>
From: Alan Egerton <eggyal@gmail.com>
Date: Mon, 15 Apr 2024 20:30:49 +0100
Message-ID: <CA+phaefJTeu+0UPg1Xbj57fDwnAW9-rvdyG5zmX5v7q5qHVr1Q@mail.gmail.com>
Subject: Re: Percentages reported by `perf stat --hybrid-merge`
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 7:50=E2=80=AFPM I wrote:
> Could someone possibly explain why my 100% expectation was wrong and
> how the percentage is actually calculated?

Replying to myself, as I've just spotted that the [multiplexing and
scaling events][1] section of the wiki explains it pretty well.

-- Alan

[1]: https://perf.wiki.kernel.org/index.php/Tutorial#multiplexing_and_scali=
ng_events
