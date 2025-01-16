Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B24A18CC1C
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054056; cv=none; b=o8AOF6uYjbZpLvAyY3pPKLp1h1MRs3oTPBybCtaYnDGz5FvXE6FBp5wsxf3VHU5FJv5yDDIxLwN+JKhEEcQ3McpUQOIggQBu0IydkmbdM5cysZ1eJYqgq4vPSFTjpUF2EefpYhrqTzalVaRQYFI2VLQcaEL6/oZ6oGW0p0bFOIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054056; c=relaxed/simple;
	bh=crPe6L9PC/tqgQXgUXhf+Q+KNG3odeSdt+dpPMx15CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueubT541vIySESYLzRvErNfzGN8w+n+esX4ppCrBVeqpTag7oF4fFPWa6QpHUo0S3/PiGiQSp7il5i+caa55ep1Kbfual4m+SzSL7WgsOBPGf2TQN/ZeTk1Z7iSydjovFD6AZ48W5o4qKafGp/AFOYIwJ0UOhBLJj6fWTlYhSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O0IM0aCI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O0IM0aCI"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso250443866b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 11:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737054038; x=1737658838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9C+G173FQhI1bxqB+XXDtj4qeOsuE8EKfsvfarbU/I=;
        b=O0IM0aCI2GXcKfViOc+9j3eeT8grGjFg7i3vlBz9S73qw5GdfQTkeuf9M8u5MNscYX
         70VlPCpd4SbFm5nm+ZzFYEnjxYhhOH0V0mVwOUi4tj7ZMwJOdAZRO7F/ZxUoV0ENdpi0
         l+0sep4whZpR/V6Eh4PFivEj3uvsDOuTXL6Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737054038; x=1737658838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9C+G173FQhI1bxqB+XXDtj4qeOsuE8EKfsvfarbU/I=;
        b=GQQpDaWfE1z2x9lOeOu9LKnedl8+kokE1IQpWRkPxgA8Nukcz8HGjnfH9EXWtlDPVb
         77EbEOzxA6e31YHC521068x47GgsJCmzRP1Fp39E5JrnuSnrcQLpGJnSPGOe9nqDzN59
         JQseIzLB8LyQqwevyFPbV8YHqbosZw9ShqUvgSZuvN68GWlhtbYXHd/x+grVhu0NBYho
         asz6NncfRfWufXgs2aH4QCu13q6JuWC1pbartyBZgCDEdjLBsa9D++MsG4LVsHaHflar
         2qtUyl3fLOAGiBUjh/qoOrOV0c6nQzAnu6lmS1MKG7FXS9klMAUrRdBYBuFPWCjHige/
         OHOw==
X-Forwarded-Encrypted: i=1; AJvYcCWhZ5fU93zAsHayy5JjFXwgD6l89eiUET0l0+C8YQumtP34DNbOSSjvFxd7EeE9e9zTZxysFTXaa8tmsQLU4eIR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4z1CU1+7zoArd4Amdrdp4djvqk4rmsPbUEn24nMV8mDLolVLH
	W6gdfkLnfYzbB2agqgFeUMYVqAFpcR/4htg6AeKO9erS9F4wCpqGimF/+LNK/tfFNEaxNBCE3Xc
	Y3AU=
X-Gm-Gg: ASbGnctAB50nd59bxZL0R7D4fqXyT4CVIxCdIBq2dec1ddpzjRH+iFteOLrlLr2kljS
	EheW+t7n41R2a1n94CDrmhtJN59dHgIT/BqSS6vPt4tQuWxZksdnbN2ZdeRUrwLx//Iol3eVfZb
	Ay2+EmqtFlO6CBTTes41Xi9KQJARdtAgeOye3BGfFc6J9LYjVc4MeETfRPWbtr4rDvAZcgOAJw1
	nMH+ezZ/g0Ds7bK3eb7g5ayB8v/9XZJwohdqL+hv9ZUCs/M0Jjdlgi0ZRbkdSYpjNGHUDAEl/4y
	NZQAq7ZNikoX31mKQsT2k7HPyS92z6E=
X-Google-Smtp-Source: AGHT+IGndlqj31u0UC/Dfhnqe/Y45Szj71Xqs7jsWYq3mbh+IWUYAAG9rwU3QOjaod94sKQrGBH8gg==
X-Received: by 2002:a17:906:f581:b0:aa6:b4b3:5925 with SMTP id a640c23a62f3a-ab2ab5597cfmr2568533566b.14.1737054038162;
        Thu, 16 Jan 2025 11:00:38 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384fcd73dsm34336666b.178.2025.01.16.11.00.36
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 11:00:36 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so2645996a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 11:00:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJN6MfdLiHvOVJwLRAvgLRtfuaChmZk7AhlND+TBEahfzoU4yRx1lA4OBEV15YNL5K/YqIYmdUO5Tagq6LANBh@vger.kernel.org
X-Received: by 2002:a17:906:7311:b0:a9a:bbcc:5092 with SMTP id
 a640c23a62f3a-ab2ab6bfb7amr3215368366b.39.1737054036177; Thu, 16 Jan 2025
 11:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116132359.1f20cdec@gandalf.local.home>
In-Reply-To: <20250116132359.1f20cdec@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Jan 2025 11:00:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiFEeyY5HE3NMvDYd254yHynzaQyzwYhv5gzRj7KU+gjA@mail.gmail.com>
X-Gm-Features: AbW1kvZhAEAPFdLu_XCSUkgL9bv7yhhorVSJTllTKCEW113vDKNfW_1s1Mdp5pY
Message-ID: <CAHk-=wiFEeyY5HE3NMvDYd254yHynzaQyzwYhv5gzRj7KU+gjA@mail.gmail.com>
Subject: Re: [PATCH] tracing: gfp: Fix the GFP enum values shown for user
 space tracing tools
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jan 2025 at 10:23, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h

No - please do these somewhere else.

This header is included by *everything*.

Put it in some tracing header that isn't.

             Linus
