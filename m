Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7087A225777;
	Fri, 20 Jun 2025 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426475; cv=none; b=FipC3Vry0HJixadxCZvJ1Keg7RoZF2ah1pK/yXv33DcCmNeut6hKMb5h6iCeeKxT7Qt4hG3wdtZ20QIjFof/TTfMpAWziRQKgIFHVi7r239GtkGpmheUxB7em10100m1B45ekUhl/NXqncckl19CYusvmF6tKEPpAWz5G5llmUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426475; c=relaxed/simple;
	bh=KdYvDLV3w025s18KRQwH11gAXy1yiUiz9j2G1EjCbbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9LN0W3eYoJATsZ1uNTSVQ5BI+akGTOx2uits+TLDPWi8LLbxP5uu6rJCYGj0+AxbKwphdg9NWd0IOE7PwU2X1oJ/gyey+CgaCJLBfH05mJ3Doe6z9blVsT4Mn36/A8G7WxArHXaRAVQeqvMyCwvw3RE7uySh2QIDQpBEFauIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaMXWg1p; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaMXWg1p"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so15333715e9.3;
        Fri, 20 Jun 2025 06:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750426472; x=1751031272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mtx9NszNi9lugOX4De6l4R92z6p4vsxHe6L4kOW45Uk=;
        b=FaMXWg1p2uAhfER2TzK72Ff+8UMvlqn2scLII0iDmi4nVAsLVhQtUDZ2zisklH78ad
         zvhf+DkIukJaiuWeFZ3rfR9q9OJ+qyFE68s+kXOcJv4I8cjebMuC3ezMpm31Q2T4JKSc
         3lqPP9Z2ZdGLMW42jWzGNT1hMkregpdoyHaUcIYpr1mUJrCFZdznd0Y+JGXVwXBJOEZy
         wgZDfQ0CXlcsEgARcmc/O5whQhWve3K+OeiNMH1xHF2oSFde4GQ7fDVgvc7lee38I4iI
         DH1dceFebsMNppY9x1B3oWhopMW0r+ZU3RwXhf6ZY8UyEEs3tdbBOALhyJaqYSszfClr
         pzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750426472; x=1751031272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mtx9NszNi9lugOX4De6l4R92z6p4vsxHe6L4kOW45Uk=;
        b=FFuht9ugDlCvYXnaIfoEteVrUfaZals2Kl99fCuBKIbet3qWTE/D+Zzz9gPzOlOANO
         if0Loe0aj0L8s6aQtY/ObnxxjX/IRkH6WiLEpnPjxcHuD8yXdKdNXWEXEZxjIyedUA5B
         0ze2iptwu6q43sbhKCxR10IdkHzcKONOZ+LD94+3u007gM5vQDWKGeavn3NjY1/9QoQ4
         803OwofwZMJk8kVtEF7BbZw3SGSvM/eOYmVWq6RmmeC90t2QaOFkxeNGCOqmQmdwFZVz
         teRcyF4sdvDAVtLTaK1t6/EY2QI1CynBjOUvyGmuRJDiRT7RGY7ZzXFpN8TkRjPOHVNv
         RDLA==
X-Forwarded-Encrypted: i=1; AJvYcCVLUVrSP+qRoL/7m/r24mw7JEU02wZ5+YqJGgvifMRdAwFkD1oJKWG0kRorTiavFvAGdl8qFselOcqEIFk=@vger.kernel.org, AJvYcCXedUssavJk+D4nFhngWFZtZ+YdH9I6hhH+vsGGqJm6Sz7egOztwAJvbOEW+YycQSJmXmeiv6TMwIU4shdFjyndtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpw5mLv8wpEkdTaRDd36MWlNvPLwcOwcxUxrFFM1TYNZJAdSW7
	psjLTiCyKAdctD/4ESOV8P0IlGB+NMGGQLz5heUtJ9qTJhnUwnnXGige
X-Gm-Gg: ASbGncuA48MKSI+Pt19pcgkIBItcQeaKMxYf7Lx9PjyAIaH/+t6T3Dfa98vzw9i0Ir/
	5ZxSD9vpCO+P7IHllFzsqqMVOOWKmAwrWb+pNwQEpQK5n+IUs9/dEStR4ZhNYEePPDaXB+Vj0Df
	BaLmApCZxr+7KGhk52ha5BIjJDXZ2x2NBFvW2yoLO/wmtZwr05+Y7vhhVDkfrfW4Ed/poP8Vd9x
	TFDFgax4Z/FaaBTiaWPXkQ3pJ960YrOwdq3rI+hGcGOtTz4/u+1p4JsshE/LknKCBK9B+rFHnaF
	b8at/6bAKRW43DiCH1wZu6yupMgqTB3ocW/QpXycrs/G7/5YZ4L/dE83FGcUMCKh4ffB/JYM1zW
	1fgYgeNeNEV+VdsCfkLeJUGGpYxUoSM+Jk+A=
X-Google-Smtp-Source: AGHT+IFtQyBDnW4T1Jvb5QOCjB4fHJiRrbtGNhV9cNoRrVe7TyYWvDyU13igPiP9nmo26VamWyuM4g==
X-Received: by 2002:a05:6000:2906:b0:3a5:2cb5:6429 with SMTP id ffacd0b85a97d-3a6d12e2203mr2441994f8f.43.1750426471502;
        Fri, 20 Jun 2025 06:34:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f1d902sm2062730f8f.43.2025.06.20.06.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:34:29 -0700 (PDT)
Date: Fri, 20 Jun 2025 14:34:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Eric Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnaldo Carvalho de Melo
 <acme@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/3] vdso: Switch get/put unaligned from packed
 struct to memcpy
Message-ID: <20250620143425.6d654bf6@pumpkin>
In-Reply-To: <20250617205320.1580946-2-irogers@google.com>
References: <20250617205320.1580946-1-irogers@google.com>
	<20250617205320.1580946-2-irogers@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 13:53:18 -0700
Ian Rogers <irogers@google.com> wrote:

> Type punning is necessary for get/put unaligned but the use of a
> packed struct violates strict aliasing rules, requiring
> -fno-strict-aliasing to be passed to the C compiler. Switch to using
> memcpy so that -fno-strict-aliasing isn't necessary.
>....							\
> +/**
> + * __put_unaligned_t - write an unaligned value to memory.
> + * @type:	the type of the value to store.
> + * @val:	the value to store.
> + * @ptr:	the pointer to store to.
> + *
> + * Use memcpy to affect an unaligned type sized store avoiding undefined
> + * behavior from approaches like type punning that require -fno-strict-aliasing
> + * in order to be correct. The void* cast silences ubsan warnings.
> + */
> +#define __put_unaligned_t(type, val, ptr) do {				\
> +	type __put_unaligned_val = (val);				\
> +	__builtin_memcpy((void *)(ptr), &__put_unaligned_val,		\
> +			 sizeof(__put_unaligned_val));			\
>  } while (0)

Does that actually work?
If 'ptr' has type 'long *' gcc will (validly according to C) assume
it is aligned and will generate a misaligned memory write.
The (void *) cast make no difference.

Using (void *)(long)(ptr) might lose the alignment.
Otherwise you may need to use OPTIMISER_HIDE_VAR() and live
with the extra register-register move it tends to generate.

	David
