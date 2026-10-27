Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123600;
	b=EbLDkGdWmWFzmIytW/rircF0QsNZGeY9xBUK34Fve0sjZrrlRJ4ihYNR0Mr7P9V7LsCv
	 j4ETFAc8Kxs9SCnXrhx86o78y6SzfbNqwkyW5hr3jptcZ0hH5IHPX3RwNtitPtRo2F4Vd
	 +k0/c2QUMSU09edwA0pCbrEMoeKzEeeZyqA5KuUcxqh689yQfokJEgfKpjLtmpPckmsNf
	 mDJ9HhFDNL0pAeQ0cyI1VLtiuxA3vA4FljYEZTuhDiNLLmGOhsc3PHgltPIcWs+uHUXpc
	 vah3cqle86zATxSmCroxSjDPalxM0zjzjH2wK0UIWYdsAM7prkiX3Dm12KLRn9xOEWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
	b=dRyhCBTVbpcsykfNonpLlD2sszVBV3NOd1w+Lgd5VtFSZvtKnDDRClET7OS3V5xLMfuM
	 p7ePx3SGaNMlEkf211i+CIEBek+sqSmpJYFs6X8oYL5lpI7SkcErhDaE7WAyK09spAAu8
	 M1WkTa7DhlEmnwPMMXq+de+MjrNWFOmNc5vdyIg1pU2TXuFndTzXl8Xtn3rKZklRUhrNk
	 zVQBQMi1VKpiKubRhtMWZZZ7hCF36SK5yYI+CsSEtCPURzKLmqcB1r1X8UejJT/8fQ5Kk
	 TazM3h6eaWHUOyYfT8KdaOEghklyr3FpwgKsK3oSIBzCaTrDZOlqTQPe+uX18bu6tGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=inJR6ox6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB017606A325
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB017606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=inJR6ox6
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c450ab1483cso13280666b.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123598; cv=none;
        d=google.com; s=arc-20260327;
        b=jDZL2PLgDL6cpjdLyf/XBLI/HZj56mf/nWfOtiRp/Msib30rjkhnOjjhr3+64Q+yHT
         6WqB5W/gXiiZ+2UpANMz2wSeAR/ectdz29scUz6uCoV3jmIQAE1ybcXbBKIgu8kdLNBT
         GFrRpaNEedbG/IjwL/h4hWiTYOpLVu0HKLPHl0fn/nTd1CN1bHIP8SbqSF0+hKnnpC24
         2Dpa+sOdzkz3LgXFBD6AlhYS4wLFkQt/4YxVfl4yvrfhFwpOcaNY9krqhnz6BQ8tnjjk
         9+EzNlZPnMiaM8jvBsTXTOsRqcEbD9fKYGtuylI/1+6vQ9JN9nHgZVSgnUP6KxSdahbg
         FSRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        fh=K1INysi0tVRTdPmxpP4PjrHDlROHOdXByd0C91c6t5g=;
        b=bUtYECXmfmjiFCXv+r5lNkAkvWuhaNfSBM5uVm7qVX/2zyVZkK2HShHUdYojSMI7PD
         AIZQUsLgVhN1mlM6R5ox2S0bpu3N6w2AdEoPzAhE33lfkcly4Es5oSiqZXV1fYnp9C7J
         l9CQuyvytcIkzTfGNmymGgGjINjtjrTJw0GDqX90N4E9O4YhUJeRDQCRDenOk7unYh6Z
         58OHZVtErzJi+4UIpDxXEquWiKPYfQT17rp37ibxzoVXjVRl+NnzqxusXtOdtf2V1N+3
         XOtfKkWSm1iKF3Rki8qY+bV74Mf74nxBcAscmDhN9SkHJ9plRImLQY7RrEJwWW26bgBi
         Yosw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793123598; x=1793728398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        b=inJR6ox6aQPgzkJ0wZYiPBugaLW1/kUDoRUxznaXNPrxE2Wn3DkQl3afONPaEwO9sl
         vnrt6FP9OFfRf9KWlwZNng3ZlaCrfp3bQxPXGc+Gx+AORrKLJ8WZpN9m6kJEM6IAqHPq
         Jk4iMXPxJgkZqxRsoYIxQcD6CPbdcJbwTT1mEJs9Oh6VfooqjmJi5DvsYqRTbZ70S79m
         W2gdT7rvplj4k08tnzQQgxgOTLo5uqZ4a0mScYBLYVaYMXTVeZPwvd3azNIWeu6/sXO8
         zyeS5P1gD5N0vXZJTHB1IRGypOyTZEZWjLyDPXDDqsHxY4MhwV784zCuBQDBJ99Srvxy
         lKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123598; x=1793728398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        b=KNKMWLi62pmO79aEnfZYk44WOavY9HE21LHRmS4RAvGpnOj8RCqn0IGnzMdL9guhaM
         nGL6XOA48XOt9xVXU0zhHEzHkdHvdFOtUTB7LO/dfss6GR9XRPXCaDcinjH3UsaZpRbV
         b72cc40v9PG2z2GQYCBJ4ZsyTCr0YBm+0KSwfX5YEc3aW8fm5xsK0ptT1Uk1ZeWcTfbv
         lhbP3EQwWJc429WnT1+x2B59v/WJJIkVPEn8DJBbZRaZJ06GqJ3PJLYsbhHfqwWX6YER
         rHaMYtS3k+RoQWr38hSphY0x+td3HQ5gHQJQYYIlHescuaaBvDtmJXTWRTR4rntqMubm
         1veg==
X-Forwarded-Encrypted: i=1; AKwUvBw8ngeVz8Yakyxc2kQCt1HI691nIMoYEP73tR4J0zGVV+uFLvV+GAlqHJMNQfqaGexdgv6eT3ZJ1LPgKp2j3jF/@vger.kernel.org
X-Gm-Message-State: AFq9FYKyaauebkFIJWAhN7FpVZ4K7NmFc90fkIyk7JMFywv9GyXw8mOv
	/QBmEmGp1O+76MjS8fzgTKvj3wYTEpEHegqxO/aPrccda2Dw4V9wWaaG3PDQy6vKba4q7sqN4Hv
	+wM9axbxi8EVvQSGq8vacCcdVmMQRbt6jd0PgfKfc
X-Gm-Gg: AYBFou3T0qEDL8sjjalnCtpg9NbcGnXHGh8jtbZoAprkrC0oJVrC9lEPUatOIlvh14e
	aCIWnVw/8zhV9Ufdsk/lgIfAwHu9IwByk+FxqqRm6kg4o4jOiRKbfkhAEFYmSnMk9jMYUuQudgJ
	l8SyCdTo1evLmP7LVuTXhdV6vkiHf81agcpurD+2tUDLsZWmJ1xBE5dfZrBvzajB3Y+NeltwnF+
	SIwJ7oHuR1oYOyyJJRnXte+AP0UEYbpkmmVkL2RZT6YLHWZH6u87w7RfMt/kGplw8iRnMsW8WxE
	0xWF9lJeyXny2zfMKbRdnKbJkVvH2u/T0cpWkztXWT2f8jhISjtXki9+mad1Ssqz8XKpTYBXapZ
	RVNEexurqLvA5Bvp9EQl9f+LCZMTZQPYWtD4O/UQ8YPkuNIYqxaw2sXLBuUR5IlWwhmz89TtOSa
	hbhTRslvY6+AVNZeMYXRRQF5Am1fxS+K6cpGSc55z2JVDdItjy2yNId4/kk4bSzQki3TS/joUl9
	2TGIKFDYbICpw==
X-Received: by 2002:a17:906:dc8e:b0:c31:e958:408c with SMTP id
 a640c23a62f3a-c46bde8b464mr1159692166b.38.1793123597614; Tue, 27 Oct 2026
 10:53:17 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-2-jthoughton@google.com> <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
In-Reply-To: <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 10:52:40 -0700
X-Gm-Features: AclHuK_7gnb7g4GjAy_SA5zcAxXhabVZixR-oCAtO-qS-tkfEqOEG_LlV9pvyY0
Message-ID: <CADrL8HVgOYb1hzWDJzm4sCrEAR7PL1xBv-1zTGebTusPoDsGXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] scsi: bsg: Don't copy sense data to user memory
 when canceled
To: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 7:41=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Thanks, Jens!
