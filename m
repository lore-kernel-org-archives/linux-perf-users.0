Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F342A80
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747169983; cv=none; b=sggeuFY2iTlUqtgBp56gPGyFx4jTBilawNUIWWaUUTKgFhjiJP4UIwEx+Pcep7HMtq5bjaUTGjiXGRxedA/2i16d6JA18AcUvJV1CKCPjOzpgxbFsMdLJ4RhYYHiIkRPxBO9mahtYC0/PTfBOnivz1ImSTKfKT1Fg190WT067S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747169983; c=relaxed/simple;
	bh=kmoujT613lINq5POisBnj8k0q5mR078aRV2JQyCa9YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1PlElgnl1FGJKKqiGo1d9zT0/mFwXyE5eGnEHNrb3IiDDwV0la8zEou+WLPxlV8tjYCC0fEVd/3PUgEJEkll/lU+INU7ECvNDyosBK9UKM4CJt/JQyQw0D+GhT2+UMtIwXDPpgrkT7u2Jyf4EosxMOjBeGddpm+8XgQ3WjibMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1xt8DBBL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1xt8DBBL"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e39fbad5fso13195ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747169982; x=1747774782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmoujT613lINq5POisBnj8k0q5mR078aRV2JQyCa9YQ=;
        b=1xt8DBBLFGEBCEhH71EydtNAsD83WdywTFTFoY6FohMH5yq1hxQyU0d6uD/WnhQDVR
         usdJuNiuuCSIhFFacoODenw/7xjoZGc8KwyNPPYJaYKwccDNYiRXWu0YM9PKB2Bon3Lw
         nbK1wUiYmyE7uTppEf5j9wO3tntLiHj9x3r9HFhMkkFRwDb9xaLvZ1LlknrJQAaC+aju
         M4FNAezG5OYfYT2imMZE6VeEe6BogL6f5UXl23XB6XuYLYe+YVwqiRgt28F9hTwuNng1
         Wv4TZZlgEWJljq6pkr+FzK2v1UEunHKibO8XkX7kehrirLnR58JPTUyJ2U23WwcenzIH
         V2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747169982; x=1747774782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmoujT613lINq5POisBnj8k0q5mR078aRV2JQyCa9YQ=;
        b=FFT21iWWIlMuUT7vAuoZfaf1TpGMiHav+vsEADwsDMqpBHalaoHoq/qVUceXbSWyIy
         jUiF3PSX0PtPgwseMTPBztcEk3kw9r6Y4it2yWf8hv6EEUxZTmFi7O8RKUyqu1xjkV+M
         xtKddgyRygbPT5xJ96q2Aefd9ukvuaxGGYcDGYHuuo0kLpZzr/8qo0Q+kryu+RoOkA0D
         ssauTLxMqVBQ3UcNMg8IRMq6yBR1o9sZQji3inTO5g8rrgInmm00HDC+fbfNeL042gJD
         j9kxUh3cQt8HlrIVoTLLeyQDjAhNQvJzqJqkMTzy9buDtKFOl00bIQTvgZPQLgGVlK/+
         RBZw==
X-Forwarded-Encrypted: i=1; AJvYcCWIUc1CmnEN2zXvBsA3fAwJn0dCpVq01ck0krkzAmJ0eyrEpdXkQVL5ffq5bK0zbqlKL6AjIfMjMljR+G7DIqJ+@vger.kernel.org
X-Gm-Message-State: AOJu0YzkI+out2EI98CnQOrIAWZ7Ta7WpAuaXuBV89gTdMRPfc8zyaqb
	az3lSTRyYFGwW3TzETDuJuELs96TtTlxetWsIaVnZwxwVlrEMnpvMMgQmrEDpJkP47B+qjg1N59
	xlb7k3fxnhbnQxuVfkxjpi24kv/fK0+dxz738zaAT
X-Gm-Gg: ASbGncu4GeXi6qeS0lPVM57UDOvBBjO/99X4Z85oYkZp10BRuOqJ57iQN99YVypo8EB
	RNYdfzAgb71adLFTMhQ0I7ENpdXkMlUJSaDfhMKjopetn+kuuIwiAdqI4vr8xTnb17IaYsMSAm+
	7EwfU0LRVwLgMvXqmjKFTtegT1sMyTl/Y2He2pFkJMWEGWL+3lB80mIsf6B4rwSg==
X-Google-Smtp-Source: AGHT+IEHJcjpKAtOS86nQV+xU9mV44SrVY+/XlpOPb9EojLJPjbR4OqS16VP12w9iA5csSFCoG51WilhKP4l+phrj0U=
X-Received: by 2002:a17:903:f83:b0:21d:dba1:dd72 with SMTP id
 d9443c01a7336-2319ab2117amr121865ad.15.1747169981479; Tue, 13 May 2025
 13:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512055748.479786-1-gautam@linux.ibm.com> <20250512055748.479786-5-gautam@linux.ibm.com>
 <CAP-5=fWb-=hCYmpg7U5N9C94EucQGTOS7YwR2-fo4ptOexzxyg@mail.gmail.com>
 <aCI0oDBSz86S9fz-@x1> <CAP-5=fVYXRzQjRzcDX0aJv5yg3bwDO+PWHfP-Laig0s3cnzcaQ@mail.gmail.com>
 <aCOwnUUVKx798Uza@x1>
In-Reply-To: <aCOwnUUVKx798Uza@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 May 2025 13:59:28 -0700
X-Gm-Features: AX0GCFsVt-eZ2CzDOIaHjUDdhu6L7-cbOlm1bATvBY8CUXJTAsFZBElBTukfvfI
Message-ID: <CAP-5=fXK9Jru+ZqeTSuaTmOTmpF3JDHDswUOcmdOyLSP1Go_Gg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf python: Add counting.py as example for
 counting perf events
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Gautam Menghani <gautam@linux.ibm.com>, namhyung@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 1:50=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
[snip]
> Right, I like the effort he is making into having perf more usable in
> python, and I encourage him to think about the issues you raised so that
> we can come to some good abstractions.

Thanks Arnaldo, can we be tolerant to API changes in the python from a
"regression" point-of-view? Like avoiding the notion of indices?
Presumably such a fix would also need fixing in all the perf python
scripts, but the external users I worry about. My sense is the number
of external users is minimal, for example, toplev I don't believe is a
user [1].

Ian

[1] https://github.com/andikleen/pmu-tools
