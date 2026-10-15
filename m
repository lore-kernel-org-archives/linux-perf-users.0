Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0140F756
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094480; cv=pass; b=SJZx7ZZYMKIccIJYTpPP1RNrUR9AiKbDO3FC8kLN5ogLiAjZXxCtN9npRrjgKmMJBJQyaew7ULx2KY32qeTbQljDoiWQO87+9gSGQPweSnHi6KNJsDfx+GRfktlLOTdDWpgTHH8BhZlnqNXQnHmramjq9cFNifMzPuys0OhCsSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094480; c=relaxed/simple;
	bh=dV1XQAwMXloRb+Sp99cSvLbnbvftAViGBxe75uiFOuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+6rVq98CLl8r4X1RY4nOkeHa3edN1VwAAO09ycUx3p61KbmriuJ5Vt0s0tABxv3Ml0OjsTPiI0P2SMIfs7zDZJO+Drgkmac2pwTe7uD6zPPLD23z8YwfPYg6IZis/BiZ+8N+jI636wne4EbFRoLi2sLanHnuWDQw/f73X9dAaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCbpaXYx; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCbpaXYx"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso429a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 13:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792094477; cv=none;
        d=google.com; s=arc-20260327;
        b=UygG7dfH33/QezbjNTGz9ky70VNlTrfrKkBi7jAie3iP7UJgjxGEa+OHZJyk7i3EzO
         xa+ByFbJD+jgFbaoF6NHSL+788mlDcjG0SDe1yqzJetAB6xdjhLls0/dwEnB62jVZkpI
         zlSjejaB7jd8mPdlY8cOJm8qnFtwF8b5vngGQ8GaRa9a9v2EXF8qkDAvevJWcNtgG3pV
         8z78HWJb441AvurTDgHTRIVsNpt1mfRg/4pNiO4ecwtSpfqKqYq/lmimeD40qS2jtJ3+
         D0aLxnHsBcqNcjbwiwBuvUoQ5qc5PtfxUQaw+rzZMCSdwGjHY42Nshbcgc/DCG8/xpNe
         mBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dV1XQAwMXloRb+Sp99cSvLbnbvftAViGBxe75uiFOuY=;
        fh=x5HRpfDXG2WLVq6UdWyvhMmSH0iFSRslfyb0CmgxPIg=;
        b=Dlu8zeJiQIxANnVpeJVAW/kosZbpNGKcNMZVmXiid4o1slhAq6jt7rFiE8KqXDyjQA
         2CrquPd8tvygedtxjee3ANdq3a39RZHYu5sufU3leI6FjdKTQdEybA2VOqg/g2BWWrqU
         4o/M+id5CkPCGleTiLTuDrE9QigWaubtvLTq9jGclCRI3wLqtffSgWpGdijL6mxRzx90
         qxv7fc4FXiz7s+r7DDJF4KNHWiHRvYvF8TbOvRnN1G1UTkf8nVdT/qSmWy3z/WA+g+o/
         IUllRdn5R6zxPGSnNMKIuWMttsEARkAi0qgVhYLMh86DBxBCC/ShEXj+OfiD4aEZtKFz
         KAXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792094477; x=1792699277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dV1XQAwMXloRb+Sp99cSvLbnbvftAViGBxe75uiFOuY=;
        b=uCbpaXYxBeJ0ZZMJS6BY7cVGcW3gCDoYBeCtHwFDe4nnSbDbEUxd4QL6T+wHuKLU4L
         CDOt2dVWW8zEKXPUnVP9AQ6UYyxEtOMN3fPSpet2Z9xJ8fxSpHGv9k3eAyL7MuezaT0K
         LxdXubKYzM5lQJV2l+ZvHB3bqbK6uv4WHClxLD2Yezu1QZO/nhbiQj8EvG1jRLUKrFi7
         2hVtJklWpmzn3j4FZGbyCEpoDsV1OjG+9tp/ufL1E1pGH89VCzQmh1GES6xaF3mKmAGs
         pL7lMpybI5cEI41/iUJV7zXCIf9jR5cKJQEe+jXvn8DrTGTDi/gfiE6onUyS/eVl8nsZ
         Z3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094477; x=1792699277;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dV1XQAwMXloRb+Sp99cSvLbnbvftAViGBxe75uiFOuY=;
        b=gKVVBYG23Rt2saQeOfOVWpclwIVj9878YwRU+4lEdPUaXCy0AuGAgHxzmvlk02Nxk4
         wpsU0VDeCn+Gk6GXKjRkdbnk4PmWlot1/yon2J0eVPMnd4sMpdKxEER0sFWkjZC82Xps
         aS15HGYgYXNYtjukNwFZYVpH152pYk2gI3zsbbsL1IkqMPtKMaEwoTY4Iux1Mtto1G6m
         H1qbmqzXY3PBMqCg+hTnVEtXNQjGSo6qTMRA/szJk0nqRzuzm/0UAD8XmNUwR5oGlbUH
         RasZDPoIx7k7J7Ah2LybGzCmTyw5wdAbooqI1u/JfnMrmuFTHUV8rpQ/MiQkOKGBqnkj
         Y6Mw==
X-Forwarded-Encrypted: i=1; AKwUvBzGS0+1PnF0g7aamRXk5k18hdx7KJfn3kaxy48DaempWWquVDzVuz1zgPmuo5VpjSR/p98Jg5mcrSZItXBrQODO@vger.kernel.org
X-Gm-Message-State: AFq9FYIAd9bccVsToVb7zGjbyd/T4Sj7qBh4XtCvmHwley52R60nu9S/
	oJkWNfBc5e2KSQC324QKnB+oesv13kEDA3LIIIMeKoKTEhj1zNXU9JbkP6nsqyUM26srAGMCjdJ
	ZiYv0yn6metumeHcDmki8mTM4I3G28o7nRXUq9ZA/
X-Gm-Gg: AYBFou2c+a0rcBs6KPsAJcIn+XXCxVtCsTEw9VvKTRr0B1t6RODE4yPjxBsvjJycU89
	kKw74mHGBq0aQpBv8HmgGDyoypP1n94dG6l3M3a0zgIYZpLVCiYa4CBgbP7TUfqU8UTXALXcMu5
	CRfSt/DqAjEHgT5v68BRd5GSgqUgmaF0z1rTu+zkcjNhp9I50jpgSfqGvPRqK1Lj/VDbAroapf7
	S5lr+pjrUg8IQ64AXh3orNaXC1QJlhMthItcyrHZy/MV3mHJXchHuT1Q9Ii/ta4yy+YDsIqDiRu
	K0pyAQe3/2p7LVU5zd1+y+c4fL/JRRmcO3JnIYr2XMd/332DeueyDfM=
X-Received: by 2002:a05:6402:a54b:10b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b38bc08d20mr2335a12.9.1792094476927; Thu, 15 Oct 2026 13:01:16
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015060430.5877-1-ravi.bangoria@amd.com> <20261015060430.5877-2-ravi.bangoria@amd.com>
In-Reply-To: <20261015060430.5877-2-ravi.bangoria@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 13:01:04 -0700
X-Gm-Features: AclHuK9lWxmIqw_gxwSlE04mTATY5Eytk1IgL6S3wq8T3iGavJHlQAC3dtBDMjU
Message-ID: <CALMp9eR=wK3mc+4_0pKSNB6y+SfXcGf0Wk=XVAwdhucyms_UCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/amd/ibs: Reset CPU0 IBS state on syscore resume
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Jayapal Ashwin Nair <janair@amd.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, x86@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Santosh Shukla <santosh.shukla@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Manali Shukla <manali.shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:04=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.c=
om> wrote:
>
> During a suspend/resume cycle, all CPUs except CPU0 go through hotplug
> callbacks, which sets up IBS state. CPU0 bypasses this path, leaving its
> IBS state stale after resume. Fix this by explicitly setting CPU0's IBS
> state in the syscore ->resume() callback.
>
> Fixes: efa5700ec0da ("perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to e=
liminate RMW race")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
