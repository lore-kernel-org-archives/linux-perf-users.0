Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396891A6;
	Wed, 29 Nov 2023 16:26:41 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c19a328797so348864a12.3;
        Wed, 29 Nov 2023 16:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701304000; x=1701908800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mfHVkbJfa0IzeYbRVGEK3uhGnyMrdpKqs5i/JayJSA=;
        b=lgt+HD1Dk5zFpt9tBWYQ0OPXjzUPrEA5vOTWVw74E7aRBuQrUQOC2zb5E2AtvsbIEl
         9LHHOkWLfRPiAkXpKI9rUllmv4wMT1KXVtWjJQb9/gw7RrLb6LRLr48QfxoSRLCLd8bV
         ZrJbdLfQYOXp61um3WWAI+dR8Hw62qDN+CYIXz50xDUC3NiMlY4uLJurconsPd5hSHNP
         eBny2scMnFEegY3kAVxtPbnBZY1JMYbDSFp15CQ+83BmpN3YV489KOd1fjSCNqc9Sqfv
         nORBVNkaoIGJgiRUBLLEDR8rBi5YYHVpOww0yISwQLVTEOwRy3FV+57Wk2YEmbHXuUww
         X3vQ==
X-Gm-Message-State: AOJu0YyONYU4otFQaZNz6tqpR/cvyAyJacEXUFvyN3lkt+iX7pOQW0sS
	4Kin3Z7trW4/9jzGYhRx+I64eYuf8m8QRTxQjpiTdC8HYkU=
X-Google-Smtp-Source: AGHT+IEMu3Pds/HHk6JlO307HXPc18MkaIca8Nr4tDqCqffNMGJZnaI1x+rjESGOU/atrN0vG4b4oLI2Jyy5pJFK5kw=
X-Received: by 2002:a17:90b:4f8b:b0:285:b6a6:c40b with SMTP id
 qe11-20020a17090b4f8b00b00285b6a6c40bmr13562414pjb.42.1701304000577; Wed, 29
 Nov 2023 16:26:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124102857.1106453-1-james.clark@arm.com> <20231124102857.1106453-4-james.clark@arm.com>
 <6bb84dec-42de-431a-b2e2-ebb532e0375e@arm.com>
In-Reply-To: <6bb84dec-42de-431a-b2e2-ebb532e0375e@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 29 Nov 2023 16:26:29 -0800
Message-ID: <CAM9d7cjvJy21G4E04_eN8wJyOSwped-q60z8hLjWZ+N8n4Ua3w@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] Documentation: arm64: Document the PMU event
 counting threshold feature
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: James Clark <james.clark@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com, will@kernel.org, 
	mark.rutland@arm.com, Catalin Marinas <catalin.marinas@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Nov 26, 2023 at 9:50=E2=80=AFPM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 11/24/23 15:58, James Clark wrote:
> > Add documentation for the new Perf event open parameters and
> > the threshold_max capability file.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
