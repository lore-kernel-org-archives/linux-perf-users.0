Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912413AEB35
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949879; cv=pass; b=jp9LjWFOLl3nLmIcXmv249JFO/QF3NndwaZAuCy5qHXUFkS1BnZClLpAUuXEWje1a0/BkUGpqOgp3ASrMM123Wk8apFxqk+8aWO/efXK4IPANzPg9xC3L7UdzbzaAgleCdh9u8rpGqeTaAj71ztK4YoS+3FPTTQ4H+CFk1yUUHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949879; c=relaxed/simple;
	bh=yeI5MCV3/YEvQ/g6wzqsSCMXaseFn+RX0ROFnasM4K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W25xqEmFcLixDKWaZBUtiRMpFA4rS0rqX3+OlbcIWmBrwy1j4PgMkkASBtaKTcHgOcoZfDjwAYK4Gcm0sQRPt7ecsgVfQcVAsfAw4l7RNsrwOSpFplNth2rvwMxcCI6XSJu2XpXjx1w35lryeYIw9l+t72ByfNeQuYo2DwTNwwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GNsdo4nK; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GNsdo4nK"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c10ed63c0so559451cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 16 Aug 2026 23:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786949876; cv=none;
        d=google.com; s=arc-20260327;
        b=If/ccokNMIytxwRdD0rysUMwe0aA+xTIOouh0v2ahKET9rqfHb18FbwQbeFzKuY2aP
         ZTRVRzZOHNpt3pZ+L+5kIm1/8Ap0md6uKBnWi/gqw6bRYFzKRAmFTnXuW8gI4xB0TbV0
         JF4fKBfdK01XII+BOmEnIZ9rFZinHNpMgReEWPA2bm4vhIj9SwyO2zKl2gkbseOWqF7t
         KgBYecidvehk2Kw3whkWYqhHSZKwyD1oVQSiSBajEsewEvgAgvA+b6QZxlna+39Z2e02
         jnU9Em0sATFxCWQALHMWrx1sZ2b+o4vAGL58rVtKXvQthLnaMs/Jk6qqic0jYnZEAHA9
         ooXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yeI5MCV3/YEvQ/g6wzqsSCMXaseFn+RX0ROFnasM4K8=;
        fh=E3k+vHVf3BMWeCuvxqYJQNVnGiDOL/7WU1IK5W1PC/Y=;
        b=SDQh2f8Dco+E4HZ5z5RIJ/fI/YcGJ8bI0N22RiJPZuGYzcSWSiOINDEHkJx8CWraVR
         aJh63Nsy6v/l0JvrEEQnAHAIkUGpNsJuBNvQozlfYpkVto2plbPZKBopWhtqnAEAVBss
         IQZ4QOSjbm6w9TJdZEaRm7RW+KTdMW2eOFLfB/DbrbgcHBbUFAP2tnYt3zXYpVtFo3Jt
         0iu1Ez+SaPBQZymS3NuTH4jLukTegx49dL+MMvtxAy72rA586lFkmFqVaoVWWMnT3aDJ
         ObLQTVJrUGEjwG+MqRG6ThaNMMOuRZzu0HnhXYs4O37HHGUo+vkJ/4I5ZnmZNCHayfSl
         qIrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786949876; x=1787554676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yeI5MCV3/YEvQ/g6wzqsSCMXaseFn+RX0ROFnasM4K8=;
        b=GNsdo4nKF6seb8YjR55OXB+JK1II6EDe/vsbe5Cxqgz+Wtm/3kezhGmnWv8VGaoOsL
         GGPB/oA0/C1NC2PAOKlPTWj6uvPH5AD9TCA2smjSCRjLWAPCzHDbMApkPOKfrWv1FrHC
         +D7dZHTH588M33qx9FlzdWAvLcTqK5Br7DOakY/JsMocHA0vmDr9Pv4DPZGfql0Gc9A7
         f3JZjjw592TGEpNemPymJ7qX9ciUsar6+YRHhJ+AK5oqTOXt3TLtkJ0t6vkMZVPzSIsq
         j9tI4gmrteedASqH83r+z1Udt9JwHjvjNTj4HcHUga9NzgGFh90GyIFp3xXkPnl5rjnI
         JdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786949876; x=1787554676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yeI5MCV3/YEvQ/g6wzqsSCMXaseFn+RX0ROFnasM4K8=;
        b=iEyUmrCGUykzDiX/TDGqyw7w3N5I1OfWAxyaHvbUVLW8XD/VMG6KXUf9CV8IVIB8nC
         vkq6lOmgHbUgo3osvEMzrghyM/DHWMVXmD59c6E3TVIv083i/GdLTlw//GoBFdRZSye+
         tmYoWm9PUo/gM01ijGk9QKsvNfmTsFknNvGtQCM8lobhk/biDDeA8VyeVdZ1gxi2FZuF
         mSplPJThHI7XvxSdRnWQm3EaW8S0XCoSyQ8zrZoSSctx4MeFFewAmkWehON9Ej72oKz9
         tIqPz4KbEfTbchz5FeKp2J5nOtJaXflskrV8r1p8deFH+jXbLD3PEaq9SD+fKvQ8nwcz
         MbeA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3B4h/gXq1Drx5r2SRdkf1B8aouScIxeOAwb0XW9UrakTw0uqxWGPoioEG6XXmF7Xh0ie0SkHwnfceQn6y4sn6@vger.kernel.org
X-Gm-Message-State: AOJu0YzGUTV9SrUQufLXqCY2GNtt9AnPydZeTEIXuGSyYX7Iy8pMl1mE
	wCrJQ5sOPhKQwf2heKJJmScObrMJor0Q7APFTC5zPzHym/xOPeZI/sll951RgyOJpGbMqZ4ovg0
	1lAKIoUvNcc3AeWR7XEvksrgTTyKGtYaZoceDg6hP
X-Gm-Gg: AR+sD13LhU7lDOMQG/qaRIxs5SICv3T3J95vxt7USFMmgHNNUtowyeqprXh6YqGfd39
	WHonuoi+5hysuN2wrk6ZA7J7UkY+SJ/UO5WHUzJCDNxpQCn8fwU8+t07jsN9osT5Mni1aVyXz0a
	7BUA1RhgciHB99V1i/DOYNoidMvMCsrzOBw1I5A9kwCFOkxIJLHpUMBbKfN8DVD9SgqsdgQeGiH
	UdJqMaOrie+RKkPcu/nuhhMNYqF7tVHMzJs8U8wLhhB+SxBF6gxSwIF0Af2EhzIL6rdqID7CDjq
	vPXacqUOcM4JQ26KBLHK2s2GObJerRx4qv4/lQeY3YOt/Ai7N3ZzMtWX
X-Received: by 2002:a05:622a:1b1e:b0:517:5ac7:332e with SMTP id
 d75a77b69052e-52db08d8f71mr7532771cf.6.1786949875662; Sun, 16 Aug 2026
 23:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815082048.4043217-1-irogers@google.com> <20260815172712.50119-1-irogers@google.com>
 <4998d0ca-eeb0-4b04-b3ac-a1f97c1829f2@kernel.org>
In-Reply-To: <4998d0ca-eeb0-4b04-b3ac-a1f97c1829f2@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 16 Aug 2026 23:57:44 -0700
X-Gm-Features: AcwNN1WIDwcRG9rKkdw20Ao8jDTswAL0Iln7nq_5f4EldOGZnTb7gA-VYM25BGg
Message-ID: <CAP-5=fVffrRgO4OM6u=JTEUwBY0np+fUExqOpbiYU1JgyMr7Rw@mail.gmail.com>
Subject: Re: [PATCH v13 0/3] perf: Add Raspberry Pi AXI PMU driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: florian.fainelli@broadcom.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 11:20=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 15/08/2026 19:27, Ian Rogers wrote:
> > Motivation & Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > Currently, Linux lacks a standard perf-API compatible driver for the
> > Broadcom AXI performance counter blocks on Raspberry Pi platforms. Prio=
r
> > out-of-tree vendor solutions relied on custom debugfs nodes and ad-hoc
> > kthreads, preventing integration with standard Linux perf tooling (`per=
f stat`,
> > `perf list`, etc.).
> >
>
> Slow down!
>
> One version per 24h in normal cycle, not 13 patchsets in two days! (and
> even rarer during the merge window)

I'm familiar with perf-tools which was set up to follow BPF's example,
both have -next repos. The -next repos merge into linux-next for
testing. I agree that cherry-picking shouldn't be done straight into a
pull request to Linus. Is there a principle against using -next and
linux-next?

13 patch sets resulted from Sashiko reviews and subsequent addressing
of those comments. Yes, Sashiko was run internally before mailing the
changes. No, waiting a week between versions (a proposal on this
thread) doesn't make sense as addressing the feedback would take 3+
months. As already mentioned, the current churn simply reflects where
we are with the tooling. I apologize; I did what I could to reduce it
and you can see in the changes per version in the cover letter that
this addresses more than just the mailing list Sashiko review. Fwiw,
if you're not familiar with Sashiko's reviews it seems you should get
it enabled for your mailing list - Linus is positive on it and it
generally improves reviews and reduces reviewer/maintainer burden.

b4 handles reply-to git send-emails with `b4 am`, each reply-to gets a
fresh message-id and that's all the tools care about. I forgot to run
get-maintainers.pl for the Documentation change, sorry. Since more
important drivers (in particular Apple M1) are currently unaddressed
in drivers/perf, I don't hold out much hope of this driver landing or
receiving maintainer attention. I sent the patches merely to help the
ecosystem and encourage vendors to interface with perf. So far the
only constructive human review feedback I've addressed is from
Florian.

Thanks,
Ian

> Best regards,
> Krzysztof
