Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51318FC85
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Aug 2024 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686077; cv=none; b=qGKSA01TNf6fvpsh0ZYILTsm5gOhKaPs2Uc560nA3VYgr1ISuvnoLa50Z74QDOqCmn3cOPwPqoMe0lSlDPrxcT8l6j/lv/S0gRA95QpQwfIZNTPC/JBX+XO1HBD7kMf8ufb0kEskEf97jvWpXHB+93d2IyHAA0czZdkYjK0Dct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686077; c=relaxed/simple;
	bh=PlDtwrmO67SXZSYso96R6JNkvkJPe+Hy8yQ+q3sdLRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgcsS5wUC+w+WiL9pGMMEYUKuWITJOewTUCTeFnJlx6ssyKLU51Xcxap8gIa9VEWZTsWPj8Q+UEm5f6hL8Zlz13ZrqfvMKqc/BzObdU1YE8iLn/P9YqA5yr/VYHph0BhFjHLcw20qtR81l3OYhQmvskZGZ/iOquEk3MUjCSc0sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhdNq2w8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhdNq2w8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20353e5de9cso376005ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Aug 2024 08:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724686075; x=1725290875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlDtwrmO67SXZSYso96R6JNkvkJPe+Hy8yQ+q3sdLRs=;
        b=PhdNq2w8IFES8DNGV+4vvZlqRUFVbuCC4krQwtSDc6rW/7qQRI83ccH3pIJ6I3greK
         kkeJ/j3y8V93z9UyPEmEEK8Bqh84sjwQ/STw9K3shhIixer+tvLDLodmRKZ99V33lV9R
         kXasYLV2hXtUPIpQX7P4sG8I4yr4dSDx+6VCtjpPjzaQigOV3G7xC+vybXrUYv4mRHho
         2wWSWFU0CzU2w8kQAn0PIh4qt/k8244R/Gi79BLynoc3LakzHa9ICo3XGWOCRiXcf3ww
         boF+Hg+i0cnC0abB0niqYO+36k64745V4h8Z+CakNSXvSgs9z3Ydg/Ju0FAkVZTF6z9R
         6daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724686075; x=1725290875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlDtwrmO67SXZSYso96R6JNkvkJPe+Hy8yQ+q3sdLRs=;
        b=HyKg7cbl+VnJYiDuLN/x7vF3yjRqTF4FBOK+7rZtgvUju5kxCGuqR+ffwmgJtepjUn
         ktRv8Ru66XxCRLYFZpTavAT/2IDpmu6Ki68sBTvF15ngBzeKnkAGGRvGJGgzy2UEOfwX
         RI+wEBxwOwV9kTkISOOVzHl/UD05Vj/78VFKHHe3QSkG9Ci4s5znrUI/e7ioPA9Bn5VM
         803p6MKeeBvPbZUoEbatKhVJsvtAmpIgfANy/GhJfIdwE8KYtklpa72tzt6eNlZhSy8c
         /xT9S+6W8R/wYbWHY6HdX6jknDtzKeneFXLcNHOdI1cQsm8bkVzQ6ED3ZVfgi+lXsSBc
         Mzzg==
X-Forwarded-Encrypted: i=1; AJvYcCUqeyvZARMu2P63CeqvB1es0ZNA4gYa8sq5OnprqSaZnDWV+b/BZUs3bkjLq+cZgA0D0DLfoq7TQqTqnDNLqu2O@vger.kernel.org
X-Gm-Message-State: AOJu0YyncmvjBYZw3e/aMJaeMabNrgkxt5NZy+FxuPp/GxKNlDfrRV+0
	FQbwcnv5Vdf7TP7U9LsczPl28V1XAeQDwJMCnnAnSaIz/5hUPY4LmrT5d4ZA90neJbz3nN/m9bA
	hbO7FM3ibEBNavyFwoNxtJj0WArJ9QYJCwZg7
X-Google-Smtp-Source: AGHT+IGN5DBP24a/7mKtrKEqJPn+N+T83aqJq5dqW7XBD+MjYknWEHtMVhWrRiyu7FJVUAAEzvhWCOIEtivgIaOV1DY=
X-Received: by 2002:a17:902:d4c8:b0:202:51e0:92cf with SMTP id
 d9443c01a7336-203b6c24ec6mr4628665ad.1.1724686074817; Mon, 26 Aug 2024
 08:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813213651.1057362-1-ak@linux.intel.com> <Zstiry-K_v51oDC4@tassilo>
 <ZsyR4eQr8X-q2X28@x1>
In-Reply-To: <ZsyR4eQr8X-q2X28@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Aug 2024 08:27:43 -0700
Message-ID: <CAP-5=fWKiN8jJ2rehG+0fw_REyYZxC3562KLBG1g9jHCyXMRvQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] Create source symlink in perf object dir
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 7:32=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sun, Aug 25, 2024 at 09:58:23AM -0700, Andi Kleen wrote:
> > Arnaldo,
>
> > can you please apply the patchkit? This fixes a regression.
>
> First one was applied, was letting the others to be out there for a
> while, I thought there were concerns about it, but I see Namhyung's Ack,
> so applied.

Can we not apply this? See comments on the thread. Basically we're
committing to supporting hard coded metrics, aggregation and unusual
period patterns in a way specifically for this feature and as attested
by its brokenness nobody cares. The test ensures the feature can't go
away. The feature should go away.

Thanks,
Ian
