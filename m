Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80823F27D
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055873; cv=none; b=jUbqreMZbe6feT3EOQaEgLH7c7UADnqab/g1H7iVo4ekTN7w1aOGYLTxXVepGoZtDEO1GoL4ZyATK9bGCIlpc10cCP0A0pi330S7seTKKQHDe8lrp4Zxmg/X8EarGy0D4X4tRuTl2WsUU5yiqDEJWDDmvUdQZkGgdwxTKj2DSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055873; c=relaxed/simple;
	bh=2jlycY9LvGGAm5Fdt5Hxp9Ba5whJHgzDPG05gxjLmTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKHNBCC6UvFYSRSWguUtqsq91iqMWNgjBLzWVI9uXceaVb6xxCdltE0xYV8pL94xVHHbegBnbuybWylG9QOl/pJ8deF5DrZm194kCWuYNvGaMd63Yv8lquulK5EFXtXt0HQpE2+/j5fJls0hj7w1a1XmVI+0m1YkXDp/N+dmQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JjNTKU9Z; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JjNTKU9Z"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso250602166b.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 11:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737055870; x=1737660670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QSOYM/2mUrieJNrzGjlGBXjVPYoZL00eeg4o3KbRfwg=;
        b=JjNTKU9ZBh9HY7SQvNR12HZdrXPByST9h98jXOi3RQS6lb2oOiTW9dVPWT9JgfGqF+
         H+BZnua6VnDREgqBOXTFWlXXTYocm9IQPG53de9punr8mS1pQSzLTDQe2jvILqJywi+Z
         Bz8b4d0nfoGTFqtwEdHEosLTAJvkcVtZ5mxk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055870; x=1737660670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSOYM/2mUrieJNrzGjlGBXjVPYoZL00eeg4o3KbRfwg=;
        b=IudZUw5OGPATHCrwKY9XhQr+HZ5GhWH7eQ+dE1KZDM5oCNKDVJRAQh34NjGErlFLzV
         7pg4KeFTeyfJCRn3SKyhmwD7OZoRFrYt3Y34kMgxwaRDitI7XdqfRL9sU73bj4j3/AI9
         UTF79Am2YebnfCPKnxIebuZSjhGJbO6wpwiyLmSjXuLxGK/CNgSYUbiLWaveAyKoTyDr
         T7TICWpE1a3nyc2h3W466h/hK0096nmdEP3h1zxRmTI3b37HUw4IL+RSNc40Rs+zyBdI
         zrP4P37ewstpaT4tgzOK1U6DFMoUag0lHIwjsHXIZmWmmRFmF1/FF1GuJYdC5wZjSXkG
         nLdg==
X-Forwarded-Encrypted: i=1; AJvYcCV922qQNIjYpClY77lYQBLDtkGGfMyChV1oZ2brnNCtc9psFlulc4FYvsV/JuLr4vYP9fQzaGdnvEsZVZ48GjvT@vger.kernel.org
X-Gm-Message-State: AOJu0YzzT1v13elleDi5cWCbwdusZzyu2MkCcToUo4ZvcHcv/oPr2jly
	2vCt0B8jOIFLunnQJ9IuUeM7+6fjahp5gjrflEe7wlshF0HvtzJwlygsJ5zCDcMJDG5AFKyfioS
	9SNA=
X-Gm-Gg: ASbGncvxKUKZ7rikjBUY5UYtl/Bnlr7PovGkql25amfJo9KsiBOmPMQ/YHccYGQUgXN
	Co8Gkypm3ask42OyyUsVfQcdoxXWQ0LEmwU/M7CiNLCAZLA1Tm4dZHuTsYF6tlgth8V2Y2RW8mG
	xqslQkSD0QJW3EAgRO8ELUc2CGP9LkQSLHb3CkO7nIbUeO4+jgaCom2AaynaKwms0GJjV7lvCb6
	Qw2uljHIHNMD8ZyMOn/qCpdOaeS4H0QJt6m3+D/CjJs5rN66792xmXzRW2DucjlA9yctyPJUIoI
	2DCIKoFbuI6pERIhxWWKvhnuFB+/43o=
X-Google-Smtp-Source: AGHT+IGS4jUKsM09LUgFsQJPUmbhUwM2im4tmnFcAma5C+L+QlE9iXvbfx+meKYA1r/ad8ei145d0A==
X-Received: by 2002:a17:907:3206:b0:aac:622:8f6 with SMTP id a640c23a62f3a-ab38b1ff09emr4163266b.17.1737055870136;
        Thu, 16 Jan 2025 11:31:10 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f2acc8sm37472366b.115.2025.01.16.11.31.09
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 11:31:09 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d9f06f8cf2so2542696a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 11:31:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiH0r5kow8ddkuxLjSzbytCdkiYoAyMxjex/IAGN0s53hzagWCMYxU9HJh3GEKM/c6RJxVWZvpT5HXDCTwlLMM@vger.kernel.org
X-Received: by 2002:a17:906:d552:b0:aa6:ac19:b579 with SMTP id
 a640c23a62f3a-ab38b29963amr4361566b.26.1737055868900; Thu, 16 Jan 2025
 11:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116132359.1f20cdec@gandalf.local.home> <CAHk-=wiFEeyY5HE3NMvDYd254yHynzaQyzwYhv5gzRj7KU+gjA@mail.gmail.com>
 <20250116141800.31d519eb@gandalf.local.home> <CAHk-=wg_2zXOKH2kDAnAyvC6MDWWgyuMRqQDNTGzKJBhfVzHVQ@mail.gmail.com>
 <20250116143018.0b156e42@gandalf.local.home>
In-Reply-To: <20250116143018.0b156e42@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Jan 2025 11:30:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHUvCTurVZosKsJhPmBJBYXeN=pNCE2nnV9EWp9P5JmQ@mail.gmail.com>
X-Gm-Features: AbW1kvZBSyHG4MwS-CjjlcCCEtuqunj8iks1xRIKuaG6PE1juORqj4L-17B5oGc
Message-ID: <CAHk-=wjHUvCTurVZosKsJhPmBJBYXeN=pNCE2nnV9EWp9P5JmQ@mail.gmail.com>
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

On Thu, 16 Jan 2025 at 11:30, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Would it at least be OK to add a comment there to update the tracing code
> if a new GFP flag is added?

Sure.

             Linus
