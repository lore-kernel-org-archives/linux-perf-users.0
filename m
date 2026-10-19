Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792426133;
	b=nMGxz+HZvRuwMkJqNPw9HOj5hDsICBjCwFYQLh4ANR0vlfT0rkhaScsE6HWq8mLIIPgg
	 SJPCX3tnlfTxDw1rBozC6WGfTjs6PitY/t3SNc/V6bKHehka9thtLFJ4x396W287TdrsY
	 uEAo/yhgVYjYnCJfqLTAk1NJ0WIhjgwwfCDYcXfyDCBZwskbtPpjB/gbjE9y2pGw40Qog
	 3hm7XflHM9BMs8FDY1gW2msVv4FGU6fFlMBb6GbBipLtJfKHq/YTU7gZReztpNue4V7Ke
	 IFs6ezRJADOc70ebhG8YJFnKV9RmxeapyNi6PpfUAnhK1Ap0JdG4EQQzd3KOP0izSaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=msDS2Uc5/Enhh4r5B5bWo/aF5i1pI4GZznS9tXeODFc=;
	b=1v6fhR+fwO0T2X7HBwizKc+WWWYxt4qPSvrbT0HAwhFZadMlyD2gf2t4EpiiLNqApsDy
	 HRFxVyqqDIvM1u7mvA+ZlazBmRnnTIR4JMWxWzTbJ9vT+QpwmDD0YNa+9f8VmSgACuzIV
	 jasOJTUWFLPzNV3LeweYglpZJXyLT59kF3101Sjd0aCa8iZTot2VOqpnLsrwqmTOHOmCh
	 gdZopkHVj+D0ZaFt5dJab+9fxUkkYRjhol9beeUkNJwaRzI1EEyY3MkQeweJb/TaORAX8
	 DU18kryTKwYhaSuAc/L6uQP2+TgaOZCgc0z+/mqVsrX6re/tTSNvxhZKiKMKWaJ5fnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m12T2hZV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DDA606A33C
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 16:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49DDA606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m12T2hZV
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso717147a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 09:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792426133; cv=none;
        d=google.com; s=arc-20260327;
        b=mXRSQHjPw02pdmxHlR0DwwDid1mMsNDB2b+73uIsKI6S3yGiwMT4kOgI2Mb3SJmRGv
         bkdGlVxy5sv6bJWivvixyLQtahRVbQ7eYgM710f46sLPABXlg5/nm0UmZDoM2IgoHEG7
         PUNdDc6gw5b5ZIANwd65iKcFldOlwkQ4MAkgjyPr0JndUba5Fs9FNPVRJDlatTqqWBXw
         zbiawiD4Hc3TwAqONBPz041NcwGlL7U2Zp6hPSNXqgyHGlSLCWRHN5ObAY7uMVpQE2Nh
         ouJUk8KSQ0hvysdZ2uF9uKjIC3nrird2zUnMxMfW0qLd/YiPC3GsDAsca5hvE2Mlsunz
         DAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=msDS2Uc5/Enhh4r5B5bWo/aF5i1pI4GZznS9tXeODFc=;
        fh=jtpvBXCg2jWSIuPNRHw58pJvPA3EYc1IKM1o1dFOvm8=;
        b=n2B2JsQ29vYVKszpSAJvCXgpQUN3dtwMvPKJi9euJe7KLuEF41fMwlnjlLHmuENMrl
         tD1Ix1xkOkeXJcx2e44Kod/hrVq+zJLHoYftqRtKhGmlraKbiU42qZXR27ODq0M+2OgM
         X7LTW7X6DaWugrxg1mb0buhMBhbBCtzpEiyA/2OKqVcRpLTct46HbAZRQfYscKpxoYWT
         SKxvGAe4nJW5hdHK6LTLxIwMB4+q42jwkQBq/1GnHFA2dr+h02GwT6AguKOw7aJz69wp
         ycOea9+VAtONK67yrZHQMeg3fVSkR4ffqpDTu7NodYOr5+p2zEplbO0yNYgOaUExDfzu
         1r9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792426133; x=1793030933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=msDS2Uc5/Enhh4r5B5bWo/aF5i1pI4GZznS9tXeODFc=;
        b=m12T2hZVaWUMbmCqdm9gVfugj/lXfdK+nmnfQA22fKj2jBfRrHywGX36XLxQA+ZbnQ
         Boj2/YgXC5SnV2N0DnStQ3awnauG5JLVr+Jc7ZzQ6NyuBV5XS9AoV8E7/ogNOv8CXMPD
         KrFFcxoZN1YvxhSfAXbZJdZSK4axGx5A/60laZgZZC+Z4gifvMOl2RYRD4uDXQC6LZva
         xQbDR3EaGDoSr7hWq6u/ei1M82R+fT2bNodj7CQtpOS335QnFEyDjH40JDgHgjihW7FI
         fT3RD5huikbzB+KqacRvyQksW/E2xge0qZ36TN7LcBtntIjCGttV9WPRE2KCxFto6snl
         RUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792426133; x=1793030933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msDS2Uc5/Enhh4r5B5bWo/aF5i1pI4GZznS9tXeODFc=;
        b=GLmtCo0y4piIm3UXtHsjwwJBZ8hJAi36GmoW23xE01bMjNdi49Ggeno5DDFkZdMvHs
         Mdpetsocb/8GUa5karIlm2HXDJAEgd4J9nngmw/jmssdSbQY5WhoGr/vKxGke8GHbpEX
         GbNI8SPDQWAYZZpe/wYRLAmsjp3aPWNdzAQzuEJXOBA874LC7goVnGsZ1DJlcs6CUn9F
         TUXzuh5fSGbqG3hcXCidA9y9xHYqOuq4LcWYoyDxkqqjFEvl/7QjZbdnjTjD+JWeDCVW
         MDRMD2BCiXa1YDwyd6DeiAvjBFleEgLB74eexjDWI3vlEgP3uKtRDJfu5RUoKPjfIfr/
         8xYQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxIPNFokWi+Ll/1OkNN7wshpPP/WfowXL19s6N51zHS04xLib/BtKdM9KSOayDhwEzUeUl589NKRZha1J/cyBs@vger.kernel.org
X-Gm-Message-State: AFq9FYKTslYvvBwYzpN7CqHxXQacNHJKLy9hXyG3j/AJnZWAqutNSZlq
	8NBDlV10PTsmFiYiiTS5MqVQDC2CZK8ePt5RfnzpJ9xtA0xP1MSq0RHrH7S3wq+gW35xpn0sQCD
	zJyw+k8l+i1c44ozx18Caf1D894ww1NA=
X-Gm-Gg: AYBFou3Oae7yINY9W/N3ATtAydHAjhLAT3rdTjM5mQoj9QtIXbBSTbzCBBH0KdhJUmG
	u6UyU7BuPlWzYHpifdb9NezOn3NHkacI5rBPBN2FEsYDij2/v9uMXwnmQcEdzZjTcmsPn+2Ec17
	ANpLgWX1WYPEovbVRNjmBAjXLd5NXzNBpluI7wIXijQB6QJMJXsUY0gJiugZx163iK8OqD4xMGD
	Y15NvniYnDNPTTNATv3hWLmCebtU9pFTMKF8DMWLdUAyW5NR4OkqGL2NmNWidZE1XgTld1KPBUC
	QAa7z2Aed6NTdzp/KlNHF6jC4332b2yYi+NXLBDB3+zZx4LzLQkPmV+GOKmZB0usqeZMYK6Eq6V
	K61Jr4YHRvcuU5yVqAeJkltDLU9r6jSeVOEaMD26Ak/yUYyFKxDMd1svJyAlDgy18jeaSOEQ4Hl
	eWJa+GE1SYmgZXIZ+iHsvG7E98/dOgo7cr2A==
X-Received: by 2002:a17:90b:3c05:b0:3a0:e4ce:31fd with SMTP id
 98e67ed59e1d1-3aceefc4ef4mr6323225a91.10.1792426132592; Mon, 19 Oct 2026
 09:08:52 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019080709.477548-1-18983559317@163.com> <atX2FsqHIkOvhrLy@redhat.com>
In-Reply-To: <atX2FsqHIkOvhrLy@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Oct 2026 09:08:39 -0700
X-Gm-Features: AclHuK_1vW8c3v9yVgPeu8TsfazzwGD9-e2JI_KbLz2M4NCvt5GeP6hDT09wjMk
Message-ID: <CAEf4BzbX7vmpd2da4eKphX1r8=QXGey_1m32-KP=-8FOkFk15Q@mail.gmail.com>
Subject: Re: [PATCH v1] uprobe: Assign session ID before publishing consumer
To: Oleg Nesterov <oleg@redhat.com>
Cc: Binbin Deng <18983559317@163.com>, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, andrii@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 3:51=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 10/19, Binbin Deng wrote:
> >
> > consumer_add() publishes a consumer on uprobe->consumers
> > before assigning its session ID.  handler_chain() traverses the consume=
r
> > list under the trace RCU read-side critical section and can therefore
> > observe the new consumer while uc->id still contains its initial value.
> >
> > The race is reachable when an uprobe at the same inode:offset is alread=
y
> > active and a task hits its entry breakpoint while another CPU registers=
 a
> > second session consumer.  handler_chain() may store the stale ID in the
> > return_instance consumer array.  By the time the function returns,
> > uc->id has been assigned a nonzero value, so return_consumer_find() fai=
ls
> > to match the saved ID and the session ret_handler is incorrectly skippe=
d.
>
> I guess we don't really care, this doesn't differ from the case when
> consumer_add() is called right after list_for_each_entry_rcu() in
> handler_chain().

that uc->id is important for "uprobe session" semantics, which seems a
bit different situation compared to barely missing consumer_add() in
handler_chain(), but regardless, the fix looks good, we should apply
it

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> But the patch looks "obviously good" to me anyway, so
>
> > @@ -1032,8 +1032,8 @@ static void consumer_add(struct uprobe *uprobe, s=
truct uprobe_consumer *uc)
> >       static atomic64_t id;
> >
> >       down_write(&uprobe->consumer_rwsem);
> > -     list_add_rcu(&uc->cons_node, &uprobe->consumers);
> >       uc->id =3D (__u64) atomic64_inc_return(&id);
> > +     list_add_rcu(&uc->cons_node, &uprobe->consumers);
> >       up_write(&uprobe->consumer_rwsem);
> >  }
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
>
