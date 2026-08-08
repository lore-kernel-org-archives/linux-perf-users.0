Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB86280331
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786172295; cv=none; b=l3ByoczfVMDqA3lv5aHs8sb91knbc5iNttXpgHIpY+9HsvdOGH6Ehz6lq2sr6NrglA1a4kpYqgDZR1XTQ63AdhqHh/iHvVDJlhYZ98+YQKv9Vr/eRAaD4Yb6jFOJfh4B3yTPnhFI99uWM5VXUkEr7IbUUk5lJlreIim/2ABjS2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786172295; c=relaxed/simple;
	bh=CMxJtGbAvGc/8HxbEIX3AtgHmcAEZ8lmjMruFgVJ9k0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G8Lbmie7chMprzrxh35mMCGhJJB50nRrtR5wnMWJVSyWSbInEC0rsAFaBBjIP364gcvbPO4XsySK++Mn8FyT98Z1s2HKg650HyYh+vfi7WjiDYjg/K2ciV7CT5of2j2qsC25f66+Dv9iCDZ1t0dnJ6tWxWu7NB+EC8tEhcx9Enc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sHl2738i; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHl2738i"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb835525b13so312810a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 23:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786172294; x=1786777094; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OsuhKvxyNK8WF2fNUEI32cJwPvrWtykzyXN+MpyTufk=;
        b=sHl2738iaoIMOGGGxoG0DrPB2Gcv0ykil8yAP81AWiN12qqQTi3vVTXVWP6HHd6ZS4
         1mDN6ylrdootJNo371YZfeMg3kH7h//TK1jPWQviy63X4OFOi6uH04U+SA417iryz4kg
         R0jMjEl4Vd92NPhdfbcbSCitofKkLNjt/eO8yN3uGaBcrLZpf+MkSWbIyojcPFJEMgYl
         opspyEXvuyLaC9PqoWrdyrfgMeq1SWtzkG5jV4dFdHNhVnOl/6ZtTnR6OV5NjMCXkw+d
         kHv9Wu3Z8Hkx1VIekDs3+RKvyvPXj48SB0+U9vJKwU6orqmRu0nG7pkuKHmBtzbj7aUP
         kvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786172294; x=1786777094;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OsuhKvxyNK8WF2fNUEI32cJwPvrWtykzyXN+MpyTufk=;
        b=UFnUtXkLtJeo3YVqwBc9rg1wj0WV0C/EWQS3AGqUcTJfLsIVYgjwfNGKk2pZlexSTY
         zdwEilqhonb8dpNrs92gf/XZfkkuaCQWOao7044z8oe+8adyWgT4ITQHoDj3AjmyVyns
         as+aK2IbM/olw5yvBzP2psyW8byKtuBz7YV6uhNM2RyGQZdBsgem3P1hZCTesSp8rmT8
         IRBHCGcDIWjDTtcQmQ7soJETenldMr7HMnbhEa/X/7IIcOpqFqkpUr+ICT7tQBWdxSkc
         vi8d6DycowlNXHgWGF0P2JuCBxi37Pne3cXWoxtb0SWUpLvNeeH9k3ZkM8k6VNRFTVkk
         tTOg==
X-Forwarded-Encrypted: i=1; AHgh+RoBbwsM11LAON0Be/Sy4vOiBfvPKi3NfPwZCViXtApP1W22qsWnjlyUr4cbXvJx9WY+VNjttnHM/3Ew9wlPeshc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh258gbtD/IU06p0I3CFiCjkJsL/Scm9iU0ffmnWLhIbiTiE3r
	7VjWjkOQniULV39SLTUvQuJRcuIMonM1bQRvvJ6YTDGUUZxspTwhSvJ2ofmcEf3WMnZjsnlOrD8
	o6LmhoxnLgw==
X-Received: from dyaz14-n2.prod.google.com ([2002:a05:693c:638e:20b0:313:fd4f:14fc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e212:b0:3c3:875d:c538
 with SMTP id adf61e73a8af0-3cbce6cb229mr6167814637.8.1786172293557; Fri, 07
 Aug 2026 23:58:13 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:57:40 -0700
In-Reply-To: <CAP-5=fU=z8kcY4zjezoxSwYf9vczYzHztiMSBvJxdwwBPVWv2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fU=z8kcY4zjezoxSwYf9vczYzHztiMSBvJxdwwBPVWv2Q@mail.gmail.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260808065743.2328212-1-irogers@google.com>
Subject: [PATCH v2 0/2] perf python TUI report and flamegraph
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, jolsa@kernel.org, laixintaoo@gmail.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Implement a perf TUI using the python textual module. Using the
textual framework means that in most modern terminals the mouse is
supported, the color scheme can be configured, and screenshots made.

v2: Migrate from inbuilt perf python interpreter to perf python
    module. Improve the flamegraph performance. Use the textual's
    color scheme rather than red and white.

v1:
https://lore.kernel.org/linux-perf-users/20250725082425.20999-1-irogers@google.com/

Alice Rogers (2):
  perf python: New treport script
  perf python: treport add flamegraph support

 tools/perf/python/treport.py | 560 +++++++++++++++++++++++++++++++++++
 1 file changed, 560 insertions(+)
 create mode 100755 tools/perf/python/treport.py

-- 
2.55.0.654.g21b8a5bc05-goog

