Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD43749FD
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050909; cv=pass; b=pAErJJ6Pd611DdSBtdA8HkgWwYtYCvDt/7pr323FPN7EARkRYYb/NaHTo3jXsNzSxxV6593tqnDBGdU1tHC6hS0qm6oCnrAHeYx/CzFhc6DZC2HSjupsfmoiaoOfa5nmnSnHEkTbWkS/9ZvqpSG9N8zOnjfabHrHArYxV/w4ogE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050909; c=relaxed/simple;
	bh=YnQSxA6vOc4L3vy7N3SIEFndSmFrtTsw7Yc0V12H9AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBtqa/iVUgGZQpoT6XmdCUh3JNEn4iLU4ZbZQ7vKa/K8SAshdrzn7whOG/67JufiKcSkcO9VVbmOgdD86r8mKfjGCl7kjcoVA3uYryrKX1acLEqKoDe2V8XzikEMyIS9uW8EaWEjCQE+0ZEB+/nyAfalPyV7R8XjVSWC0RO7WYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCgAiTVI; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCgAiTVI"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cab973140bso24059865ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 00:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785050907; cv=none;
        d=google.com; s=arc-20260327;
        b=M7Cgc8Kbz0ePwifSaTWm5c/4MOb4cg3EIGFrR42CzQW8g4A0uEs7twgfEDRaNKyHAX
         LPkfcu/OMbN/CFTKHQ7EwAytCD8KV7ZLNg5iXG7vWH5SYcLOAZsJeUnPXBFtB67o4OQt
         mFwRwZXogEIKm4cEJU7LJRBFtLu7BCPgIahZ4F37uZmIAynpZ2D9Sz+QIrt9gFTK82nU
         RJFFWv7LW2CQsreL5J5MhgBQyCVtQYSHg5yxYAWptCFKTjM3T5ovW2C/C2zFso3bXQjD
         tj1RhKLkHsJ59EzI4RRP8OPgRiI7gL3rHUvROD9j68IyVWr/2a53sc6/+C/gBM3oP7ek
         r7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MeZgOjZ9fB6EjuAkf8ccBhVqZofI6hKeYPctz9DlCKk=;
        fh=lRVI8MyKKmbz39MJanoC+i6zN4oD+BzNK+2W1T45zIc=;
        b=LfL0k4yn1HtNmKQy6JjREf4WhJtOc7plGWHMJuybmcjBgDR73t5t+lpErW0RAAQUP0
         d8GKZHrHb3VQpiccCMHJ1hB92jdGH8vAbC9RabVDs1eGH6Brnci6f+vq7gmWNzoLWV3v
         umonLXQOk1NMOIGPJArBxmjZw0bi/qzCg6vHAkQpTe3olGKBi+/MwkTpo3ouqveoP866
         T1oZmaIvv6RoyOcBiojXULqxzoMkncqRpHJUZTT6AyVqpp5BSXlFUqaV9uCceWcoRvxc
         Ve27nhUn8y4xciGXNnVzYxc7zh+kTTlp+bABjcuNKJwX3D16Ye2mDNM3n0t3mh3XvJEx
         y/fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785050907; x=1785655707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MeZgOjZ9fB6EjuAkf8ccBhVqZofI6hKeYPctz9DlCKk=;
        b=KCgAiTVID2AWkA9m75V+zxXT29r04XQpF7RlSRr4DulTCQlPVuF6g+fhBz5uAEwP88
         3nx7H39EQ46RtQoGay2Ha5WH5RdymQhLFjL3zhPML+a3KwbuH/pIesFHF44W7ZBIcqxy
         9hIgscEaQdiKlFiNXc4aAh/wcgChbti+lWKrJGZBI9XqkJC5F0qhj1flptgZF6qkliOA
         m7zNc7uCQa5ztbZ0RuKzKuDAKO79CRNqO680uD2mPTgKFe5llFI8ptgOrVSOfAEyuQsp
         FHX9q7+Ogsx59azlmplfow0oVmm0OAalcrgLiMgagcZntvjAPGljTNaz2VEatDTwt4bc
         KaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785050907; x=1785655707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MeZgOjZ9fB6EjuAkf8ccBhVqZofI6hKeYPctz9DlCKk=;
        b=Qi7i4Psi03amq/Vye+npRxvF3XAN+QYHBAnGYVpSFrERFms2FPyUBt8FqBPMn/Bk/1
         Jh4+AQbj7aJO28H5Tk8c72ZxzIW44Y+/L8jXHzzsmyjFMcviiu3G2mvkYDrnro1JviaL
         RZII25oZl2Oft1l9H+RWQyO/zDjj2lZ5UtiMSUEQy0zMUImwMXfVxMm15Tu8tJ6wst7e
         dX2rfLJO4eQdqRRmSN5PZn+Phbzo6mFe5Pka3jJd3QtC4PI0Yp8F4QMTSek4Cslz9zht
         RQ4+jFH41CRRlcUwsi10BeARGlgFVRxl0y5leEe33Kh3kQ+tAk9dFIyg9OPWYLBPc+jO
         Zl6A==
X-Forwarded-Encrypted: i=1; AHgh+RpBFAOZ+eYEM2VocNj9eCsRSbeOg5t/w9iIDypaNyuD2xNqSSVVwizCR+/LDuFxQiYpkBP1Q/s7HZqKUdBpC7l1@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQaXD0BYxEODpLQOeFFobnMZKfzrIW9IUm5vHe5+o9iTIY+Rf
	rMCafulUfcqoTgadnCy2mj6Gtpi1i2KT7nBi81xis/dWuWMCUrciZ6rbBt1xzxSqrjKQAz47+NY
	ATEpJGcMIMzp4fheQGgkjUoqDYp/5+I4=
X-Gm-Gg: AR+sD13fOcN7BYVZPBl6AXgH8LFsnVquPwe7KtyD1XWtD+H/ck06f2JMCUGxgxeqyFs
	hzDRRIJvGjLuyhAm4EMVHDc1r33F1ZtZpgkkK9/mmUP53SvTxpjCvuH/0MKyXkKtQgdSSRYp64k
	SksjmUN9VpdvfwLYa9Dv6V4bwMdbYo0mRcwEKvSpbU2xYc7LHjAWcbIg9eyuUfeWBcYCT7vnYv+
	R+zpoRNCaW5FOUq9qK5EkjrjhEMH5hogYBbMZNad/yn0qenKSid9PvC4VL49ZDLy59OTONr
X-Received: by 2002:a17:902:e804:b0:2ca:d172:7228 with SMTP id
 d9443c01a7336-2cfde7a73a4mr46103665ad.11.1785050907492; Sun, 26 Jul 2026
 00:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-af-alg-harden-v1-2-c76755c3a5c5@gmail.com>
 <20260603133312.12848-1-freude@linux.ibm.com> <amOGWwdjnJqyxH5L@codewreck.org>
 <20260724160034.GB2032@sol> <amOTjPW__CNZui3_@codewreck.org>
 <CAFLxGvy+ec3nQLrQtwFZgGELhT2pKBDnHdD0pMvEGh-Mf3rjgQ@mail.gmail.com> <20260725220443.GA41199@quark>
In-Reply-To: <20260725220443.GA41199@quark>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 26 Jul 2026 09:28:14 +0200
X-Gm-Features: AUfX_mzf8K1M0e1Vg7IaGl-nBN4a4aellAj-_sCLX-Ln3es0XP2ZaWEmYseqOmw
Message-ID: <CAFLxGvyBGzfwh61F5YkYqctNPCQJCpFOwTtKfDs4L+iK8WJZpQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] AF_ALG: Drop support for off-CPU cryptography
To: Eric Biggers <ebiggers@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, demiobenour@gmail.com, 
	Harald Freudenberger <freude@linux.ibm.com>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ardb@kernel.org, axboe@kernel.dk, 
	corbet@lwn.net, davem@davemloft.net, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, io-uring@vger.kernel.org, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	skhan@linuxfoundation.org, willemb@google.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 12:04=E2=80=AFAM Eric Biggers <ebiggers@kernel.org>=
 wrote:
> > You can create a CAAM BLOB (a generated and sealed key) using the
> > trusted keys subsystem and use this BLOB
> > later in AF_ALG to perform AES with a key invisible to userspace.
> >
> > e.g.
> > kid=3D$(keyctl add trusted mykey "new 32 pk" @s)
> > keyctl print $kid | xxd -r -p > blob.bin
> > Then just create a caam_pkey_info in userspace and feed it into AF_ALG
> > and perform AES with it.
>
> Well, specifically AES-CBC.  That's the only one that is in the driver.

Yes.

> > So, pretty please,  if you kill AF_ALG and all this, offer some way to
> > achieve the same in userspace.
>
> If needed, "cbc(paes)" and/or "cbc-paes-caam" (whichever name it is
> being accessed as) can be allowed as a special case, as a stop-gap.

Would be great.

> This would need confirmed use of that specific algorithm with upstream,
> which we don't quite have yet.  Dominique had a confirmed use of
> "tk(cbc(aes))", but that has never existed upstream in the first place,
> so it's not something that could be allowlisted upstream.

It's "cbc(paes)".

From one of my demo applications:

struct sockaddr_alg sa =3D {
       .salg_family =3D AF_ALG,
       .salg_type =3D "skcipher",
       .salg_name =3D "cbc(paes)",
};

> You've only mentioned that it "can" be used in this way in upstream.
> Can you confirm that it *is* used, and with an actual upstream algorithm
> name, and if so which one(s)?  And if so, would you also be able to
> share whether this is for dm-crypt or not?  We should remember that
> dm-crypt accepts keys directly and AF_ALG is not needed to use it.

Well, if you require me to point to some open source application, sorry I c=
an't.

But no, the use cases I know about are not dm-crypt.
It's more allowing to encrypt/decrypt data in userspace without being able =
to
extract the key from the device. Since the key is hardware bound too,
it is device
specific and you cannot decrypt on device B what you have encrypted on A, e=
ven
if you share the BLOB.
So, it's more like a building block for a poor man's secure element.

At $dayjob we've been recommending AF_ALG because it's a standard interface=
.
Not like other ad-hoc horrors via sysfs or worse we've seen on some BSPs.

--=20
Thanks,
//richard
