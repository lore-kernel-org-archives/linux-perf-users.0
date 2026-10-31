Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793428557;
	b=H6/cLXPZcKdWN6EETuADTAYaZG92TT/t0FewP2ZE2zfJ/Je4TVwgY6n6VtSOr10KQhgC
	 4cyj2czomivtGkPyOzw+vufFkqt5hDnXfuSxB9lwjcBdoz2yNsbht0c92B6oFuJMx9BJq
	 cz1dbAse0qfbeFNlILlQFrtjAMIKBW2dTV1i7jbYweuxIRHUBuyxbbEpJCihy3paGJfZI
	 wbNMzchtXQpHYxt0PwItEhuZ20cuPXqOLaEmjXhKEE/b518dSd+z1SFWDHZWTYWuE8h9N
	 cwYeKQdzQFA9cKtzyq9xwmpNV1PpGDqZnc1So92Ow6Byhcx5LfZd6H0WCyLT9MvyPKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793428557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=V1iyPpXNxuCTE05GQf3YfwT3z9gwpbdB+e14JlNIXAc=;
	b=WsDCTs0MBqBNjf5/jPhR7VsL+k8/vLYf+fHaUu9FiRTkRg1EhZ79r0IPeURa88w7qsYo
	 +IoMshSlJt6iZkwMru4ArKjChiv6hK119v/uOeJ6gBcu/BkWBIjkKWVBrpicp9NshIN79
	 kWncYZx06eemgVmckEWwmJLhdwBdQ2i7mHeh6wD7zPtRNGsIdrpsw3tAHPA+UoJcDgxqK
	 JinLXlZRx9a/uIBvc11whiiXHD6w14vlRKXyBb5UtKxsLlU+WBi3DYLat96SxfNDdcQCW
	 fxyT2Yy1JUH4vhgEY1dEC6s51T8OOU1iUrhqbyQunbOZ3sX73Uz3dnSztGOvvX9sskg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HY7LdNlW;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986C606A31C
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 06:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A986C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HY7LdNlW
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a223755e4so5745028eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 23:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793428556; x=1794033356; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V1iyPpXNxuCTE05GQf3YfwT3z9gwpbdB+e14JlNIXAc=;
        b=HY7LdNlWl3xyv7R4MZS1+26m0bFrVUOgM5rqY+BcvaDWBKDR4wF88v+mUi6SDSRitN
         C/pn3HEAqar3PaUgS0hv75qqcdnXQQ0dVLlPdriX0xQDnECb+9vP7pkc4jDq6VjHXOII
         2qzBcQamxh7XxVz8ZibmXPclrxEmJmUfZRuf9Wo5bL8NI/Zb5+U//RqZW3pf7Zr5STQ/
         udj8dcDJmPxHXng4YwjNmkpgKdCDOkZE+JUQLLRfwq+8yBVbxrYydZFN9UFg3awwOzPP
         bBiP6By/jiTDs7np4+aUTIWWsa4OMifR4DVfcruPbTCdFkzjRZT7vth3op8GHbCPtZ1A
         +j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793428556; x=1794033356;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V1iyPpXNxuCTE05GQf3YfwT3z9gwpbdB+e14JlNIXAc=;
        b=1S64nNBTjn40KOPbus+Dr7c/5Z4daD9gMwpaUx2QJ1YffUh3cP8OC7fmwdi45ilnyI
         p22iqaRHWY09ZpYpRuN7ZHNkuEH3XOsjVGTbZAyD69Gk/1zlBtWltQRjz689ICQX+/0h
         TIEBNoThIFfhv00XmGvrJscW8aZYLwo06BX2WNS6/9J+cv2r0CmXjDmxuENeW4QlrUO4
         ZyxxaJqjanPgoiU6nRST0OGBUoNl1OvdJV97OiMAR4WCIq5GB4TYJLWNesSmn9TLRUra
         b2lz/6mMSAWstK9f6+45EyMBahXz8LTHHqY3Mt+1n3C4fxC+nFQE5W5l4jb+SsvjaZUJ
         QihA==
X-Forwarded-Encrypted: i=1; AKwUvBx5vmk17KJY5kpqlWw+bpt05E7ZITyNVZQZbcIiR42EQ8tXt3bCSQd4WcjR5okARjFKIsXXRe8vBdulqN2A4iKk@vger.kernel.org
X-Gm-Message-State: AFq9FYJfmyzrcvwCzeho3qHBuuZRa3wBZiurr2nNA4XGc2+CYcqSBJm8
	feke2yT1xgT6m/u3ew1YLmDOFKcQreTMilbvsb8G38s+MALTCWMjAGotkNjiWnmNcY9egEhJI9y
	0zD7ZRi2rhQ==
X-Received: from dlef13.prod.google.com ([2002:a05:7022:b0cd:b0:1ad:689e:820])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7f12:b0:1ab:faad:cc9
 with SMTP id a92af1059eb24-1ac5bbb503dmr6067332c88.11.1793428555302; Fri, 30
 Oct 2026 23:35:55 -0700 (PDT)
Date: Fri, 30 Oct 2026 23:35:46 -0700
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261031063549.1281324-1-irogers@google.com>
Subject: [PATCH 0/3] perf symbols/callchain/annotate: Bug fixes from symbol
 reference counting review
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Alireza Haghdoost <haghdoost@uber.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

While reviewing the v2 symbol reference counting series [1], Alireza
Haghdoost identified three existing bugs in callchain merging, ELF
zero-size symbol end calculation across .symtab and .dynsym, and basic
block range splitting/cleanup in 'perf annotate'.

Pull these three fixes out ahead of v3 of the main series so they can
land for the v7.4 merge window:

1. perf callchain: Fix loss of symbol in merge_chain_branch()
   Restore .sym = list->ms.sym when constructing the temporary
   struct map_symbol in merge_chain_branch(), fixing missing symbol
   names and inlined frames in 'perf report --children'.

2. perf symbol-elf: Fix zero-size symbol end calculation across .symtab
   and .dynsym
   Move symbols__fixup_end(), symbols__fixup_duplicate(), and
   maps__fixup_end() from dso__load_sym_internal() to dso__load_sym() so
   zero-size .symtab symbols do not get extended across following
   .dynsym-only functions before .dynsym is loaded, and add a unit test
   in 'perf test symbols'.

3. perf annotate: Fix block_range symbol loss on split and leaks on exit
   Preserve .sym = entry->sym when splitting head/tail basic block
   ranges in block_range__create(), add block_ranges__exit(), and release
   resolved branch_info addr_map_symbol references in
   process_branch_stack().

This series was prepared with the assistance of Antigravity and Gemini 4.

Link: https://lore.kernel.org/linux-perf-users/20261027231513.816148-1-irogers@google.com/ [1]
Assisted-by: Antigravity:Gemini-4

Ian Rogers (3):
  perf callchain: Fix loss of symbol in merge_chain_branch()
  perf symbol-elf: Fix zero-size symbol end calculation across .symtab
    and .dynsym
  perf annotate: Fix block_range symbol loss on split and leaks on exit

 tools/perf/builtin-annotate.c |   5 +
 tools/perf/tests/symbols.c    | 169 ++++++++++++++++++++++++++++++++++
 tools/perf/util/block-range.c |  16 ++++
 tools/perf/util/block-range.h |   1 +
 tools/perf/util/callchain.c   |   1 +
 tools/perf/util/symbol-elf.c  |  36 +++++---
 6 files changed, 213 insertions(+), 15 deletions(-)

-- 
2.56.0.317.g454f8302e1-goog

