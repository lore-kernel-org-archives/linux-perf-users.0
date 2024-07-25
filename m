Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA171770E9
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938310; cv=none; b=AXL5iTyWvKR6AJo9BBIGbOkla6eFoxlPNNss7CAJ15hoWojbYLc2byC1Cby1uFnCwII7sDY1Ww0NqX5jAd+/nXOn1ePm77o9qhbtQoJetTAxmRGAv7SBa3zudYfranTRNXRnQhfu8cmnEKZkdg9PUywHV0I3ZTVACjRZpYjiJSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938310; c=relaxed/simple;
	bh=IvdqZvTacjy6MAQ5qDRh4fw3aGKlpJ5TgBBkoXVfd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtNe52E3xjIZEqBUM/tC7maNPhLRTFL8HJUHYXTuN1OREZqmj0g4XfzhFGQYGDO5IlvVyAPGbJct7FnFtTGXij/h6twZ4nVmHWZo/jLKcusSBfp7Fz/wzQ1qhjZDWJMorNDKeHgDCd0ncT4dqF94FkvP7BMedcmOO+jUoZO29qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UtlxkOiJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UtlxkOiJ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42660b8dd27so10360765e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721938307; x=1722543107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=UtlxkOiJaNxEJ7GCiFTiyCfgnTnR7dJhHbUhconsbhoWe6gtIufbwh6TqHC7mOqzrP
         0uE5MPjYPHeLE8euOu6aIDxUdQmKu+OSGTzIJx367aundxX4ZMI0WfXizDrfw80SmPr8
         GBac0wxX4ru4j8IUq/YhdqJarmB4oKIqs9XJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938307; x=1722543107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=tWBKthZhtF3l95h7Yyrdtij2AwYnJQ6SzTXnWIkjpzg6H/0h/afL0gobVRS89ijRqd
         bojuc87ExmO7u8/JSEYEW2TXeNvkZUQsG3e9cDpB01KfIAXWsNCwYg1w7QqrX1uEtndg
         fh4zdrhvMS9a3tOxO0tqy+P4YfOHTkRzRyItfApgB07Y+fCcPOE4RaS5YKa4H7mWz7Zl
         H60Ont2ZsX0RyogV8QcxR9SLJ6uNtJJgnwwah6gJqipG2Idmc2FPZjgW0125puw5CvCA
         luIjoZY8mHYE11N6fARcFXW/Yx9T3b6bVduRintdVtDW7ixo/zSkSEiLYq3mi0PYUzJf
         16Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWC/Zjncy47BK55mI3Z1l4LR+wG3NXGIyVvlwYtC3XDGFfx3+s+0XKSpaT0+gnaGM3Rh9YZwcL57REDCdSHBqd35bA/wU/TmhRYVt1chbR5yg==
X-Gm-Message-State: AOJu0YyFT+ayiUnK/iXRax7TtAOaQ6O/bk2+Ym75IJ5hbdosmg7xg/sr
	09ScX+X88X4jAudK/mGO8oH372sHJ76aCitJc91WYRhJaLcyQkycVYTr1EptxiQVWL8gGkuP/Ra
	Ak/k=
X-Google-Smtp-Source: AGHT+IHhSg9iFG4ahqCJzGWtg1Qh5n5TFpeJvPuOczmaBsJv0kTsfs/6RH0SkCQXkJpqC0j1Fluw1Q==
X-Received: by 2002:a05:6000:18a1:b0:368:48b2:95ec with SMTP id ffacd0b85a97d-36b36381ab7mr2818251f8f.1.1721938306772;
        Thu, 25 Jul 2024 13:11:46 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac65389085sm1094732a12.80.2024.07.25.13.11.44
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:11:45 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so1635788a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6or8IRlxyST9kzFgkm8QzOFUJpK2Nv9AOFpUbZvhP5LqGyd+503zW1F1mfRNbMIAu0b0tE4lnx43SzS8HvIfVGjEd6yCJCtSWYYjpe0OgQQ==
X-Received: by 2002:a50:a686:0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5ac63b59c17mr2468749a12.18.1721938304541;
 Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>
 <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?B?VGhvbWFzIFdlae+/vXNjaHVo?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 14:00, Joel Granados <j.granados@samsung.com> wrote:
>
> This is my first time sending out a semantic patch, so get back to me if
> you have issues or prefer some other way of receiving it.

Looks fine to me.

Sometimes if it's just a pure scripting change, people send me the
script itself and just ask me to run it as a final thing before the
rc1 release or something like that.

But since in practice there's almost always some additional manual
cleanup, doing it this way with the script documented in the commit is
typically the right way to go.

This time it was details like whitespace alignment, sometimes it's
"the script did 95%, but there was another call site that also needed
updating", or just a documentation update to go in together with the
change or whatever.

Anyway, pulled and just going through my build tests now.

              Linus
