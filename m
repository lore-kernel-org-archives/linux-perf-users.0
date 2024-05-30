Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E233D3BC;
	Thu, 30 May 2024 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088150; cv=none; b=MrkKUoETFqg8BJYJ6IzAcjz84k8AnJeb9fsi4VpYvT7uteRtB0RsK572MoiieJTeZL5Gzb3oWhm24Tg3zxQJjGGZSLmAQT2iueMKvuferlzMmZldMHbOOV2KOUSEo6BmAFN/tYnYb4o6C622ZVaRcd3+vZPU+CUA15MqzhzDNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088150; c=relaxed/simple;
	bh=Mcypc3pzcyEC4RX3ymnP/LrTxcRTAOg0i4UVWCMrfXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZOGXL2F/jsSX7XqfoMlBNh5xuPX94TBGFORfGIaQzD3QlgIwYyMt0WbLPJ0AUEfS52jU8+GJU7kUonewYy6/YWy7d0Wlu22h49BQirptL5VaiY33TdvPCbRsjCqFagtFUCm7giJfF4PU5lx0QtsOVqWjM5t5VfUGbdKqKBUpa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bdb61c5fdbso863821a91.2;
        Thu, 30 May 2024 09:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088148; x=1717692948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuVxUJ7dDTO9+WhdwYly/1XYJlY4BFEohmb9si0wW0M=;
        b=aqWXQPyCE4iYahTmQpynyzuN7BS9ydf5tTjDXJPKpsQmhPkvgHECTVqMIcMSljflQ+
         D1yKguG+iNKbO2vfJRzBN4rujfY0Vr87hH6A4PgU1pGXFrUO9fwzZ6p0OrMuQUQwZC+o
         3oBGSkTUpHfVUN9vnmPFZAniepRpC/71e+hFMcCv3QWhfDkhTJ5bwUAHvyIn1C4WmNeq
         tp1x6lj4RH0L8NCbBXeMu6rX6B1dn63Gm1Mh36sfTHa3A+Ho4xY6wy1wGr2jV4SaQxQs
         Gz+5DXfCDZ/b5LjML4PqvM9nDHlggVESl8gVawthE5Sr3Nwgo7/eZo7s+Soyc1CvlzIX
         eb0g==
X-Forwarded-Encrypted: i=1; AJvYcCUFgPjkMVrI7EqnR7PX7+rr3ge38S812/VOt71HllQ67NlKMjpZ9JkRQcwmAfk+Wp5kudai8tqb/VkiNZ1xVNdfTTGDF5xyPDQ4nNvoUVyvW2OWJPvlC0ftGRTGUCOuXjR+XH/UDpplW9WyoTtrgg==
X-Gm-Message-State: AOJu0Yw5q3PJ/1XzlfVCSRT9+GGwdfUJt98GakdL7jZN7dYpQPibj+nO
	KJAoUhTqDXnvwW7tpicUgb/+GEReBKIXA7fk2FtMR2p3i2dlyI8rAWJzmnw9YDNJUpN6ca+gDOz
	VnQgRJJ6N5zH05j+zLCpVc0G5Nl4=
X-Google-Smtp-Source: AGHT+IGbj7jQTNlYra84R0JTmsJ9T/6olo4gSHh6yJ3sDUSG8y2XJ22fez+UQNyD+hLB8nARNoZ3W0OU3r4FlUhr4Ic=
X-Received: by 2002:a17:90b:1643:b0:2b2:a1d0:b61c with SMTP id
 98e67ed59e1d1-2c1abd732b8mr2221362a91.47.1717088148414; Thu, 30 May 2024
 09:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526182212.544525-1-sesse@google.com> <CAM9d7chY7CzMx9sSYeagDK81PsE=soGmn4AUxXAE7rHp=jmx3Q@mail.gmail.com>
 <ZlczO4D8J1lgWBZj@x1>
In-Reply-To: <ZlczO4D8J1lgWBZj@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 30 May 2024 09:55:37 -0700
Message-ID: <CAM9d7ch5YSYEadbVV+LRGvppUr76rjfxMnOp2Q2AqgTBAff7Xg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] perf report: Support LLVM for addr2line()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Steinar H. Gunderson" <sesse@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, irogers@google.com, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 6:53=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, May 28, 2024 at 08:56:47PM -0700, Namhyung Kim wrote:
> > On Sun, May 26, 2024 at 11:22=E2=80=AFAM Steinar H. Gunderson <sesse@go=
ogle.com> wrote:
> > > +#elif defined(HAVE_LIBBFD_SUPPORT)
>
> > Hmm.. it's unfortunate that we have only one addr2line
> > implementation at a time.  Maybe we can do the same thing
> > like in annotate with objdump so that it can fallback to another
> > method when failing.  But it'd require more changes beyond
> > this work and I'm not sure if it's really worth it.
>
> Right, I think we shouldn't delay processing these patches because of
> that, we can do it as follow up patches, both for fallbacks in case we
> can detect problems like we did with capstone -> objdump disasm and also
> to be able to compare outputs in 'perf test' shell scripts, discounting
> known/expected minor differences.

Yep, I don't want to delay it unnecessarily.  But I just want more
people to review and/or test the patches. :)

Thanks,
Namhyung
