Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645E35B14E
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701842; cv=none; b=m43K9lJ61RNiyzMLC5zUXh0UeCgZF+CsADNmBaBPZgzWcu0wIUIIDVHLnXprLdRRi6Ex7lVzDqTxui9fNazmhOFFN2NG75bfbP1zTpliMWWI9wTAnSLCcICz/LgPrH++mo86pDViEHChAjcH74nMy4vK/wqA0haFuQ49m6SfcCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701842; c=relaxed/simple;
	bh=LQ27SGnhSnnbMMToPntt2pVjSg4TacVokPJcFFAnBA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrHf2vuxzIM9l7rMQooga4uQw+QGLGwqPtmM6q7uKIXnUgVobVWSlkX32TeHCUwz50anduOt8HY4FkkFw8U9ljnIdyWRO3ogB2ILYsHJv/mFYcXY2KbC3xmhp9ZZF7xEVgfJgR7dnsmi89BGP6Q9WNhIZunD7HTzrugTm59n4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw1pPjKJ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw1pPjKJ"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2caced6038eso2273505ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 20:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789701840; x=1790306640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I4VTKLFOwO7G28r5xSijwBkv4U4UCCM3cOPNTeBPbTY=;
        b=Hw1pPjKJEVH2bA+EI/J8yI4S8oAS6kfHKZpZUYV3I5B9NRRPXN30IDLSEtM4uUcX3k
         E5ScgLGkHQQ6D0i5SmaafP6dnWiddknn5SUhGe/9E+ps1ZlJ3WJ0+Zng84fIuzInPojo
         uBrPJJUxDldbQb77cbxgxFNbeHX5SSsGeBBdpuAezltBRjnJCCy2y+OXdFTRUyIxSj+6
         W8iaa/xn9WHVB2/427ElLimCpETEmGprYZQ+fszde0LxeTg+ciQWbopaDZMCEDeFOAXb
         RrRcCKRkARwWyiXfpp5AswCECiUEkmjvumb0Ilr+wcgQcrkHSDUFiLqbl3aBMi81gzGH
         DZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789701840; x=1790306640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I4VTKLFOwO7G28r5xSijwBkv4U4UCCM3cOPNTeBPbTY=;
        b=yV1Rhh4r/VAsBfFhpR/wg9nrKnCZIYSoqy33gxzDR43De+DrzHm+6M3keuXUbT5E0K
         tLlMOtoFYJQu4BFi+tKNP9WJ2Mfpj+RWTdDXs5KhdbfCrKFzn+WVrQNgOKV/ld+RrF/N
         ebqzZxBSo+f4nTcLw9CfFhBurJl3xBXaYjJBCeWj83Axsu695Yp0PTCv9GSbhpZdbU+f
         4kkZOjkhgu837MSDUWV4JherslJBsFujor1oGBNbh1HfNN7/NF6QUIKGYNWG8SNc42Le
         xoGD8qauCg9pJLCmA0aToZg4Qevf+W/kqxiVm5PMASCAV3bG8xtznRGsXQl/5KfpxIoy
         lanw==
X-Forwarded-Encrypted: i=1; AKwUvBwLVlj7cu4y4GEsiZCZ2jYqP5bd+J4FD+VRp4MieF7Kyeqjzo06qzU2qnIoYqQJiMxBkwdHE2/jMlV1JloNVit6@vger.kernel.org
X-Gm-Message-State: AFuF++k23GCLayAXO0qWFiZC7GwqHrWjk/PDIy8dscR9U7d6ggQ7Nlij
	FaRWP62YIIY6HXLuxdDqcEbF2vzR/gIWLHXIMHQsuF8AO9t+dnyg0xwu
X-Gm-Gg: AYBFou2DxIfobn9+r6joeslvvr8wnoXntpxYRCW4YpJvfshokw3QxN5eUzK51MKgERK
	TFiNwafJN5OJkx6JIH5kxbvxgJkUsvItnYH5A7Zhh/VTQwnYGkXpobA11xgZ7+IZB8vbpzVWu2m
	j9yjpcQcYRpytsJAN2D0LHPYv6YogLSrupca8NZCeK3o36Y5xIsikIP7BC0tvY7MCAOMOvu+TLT
	zbU8YESVbI7WD+ju6z1yx6owiOsN6aKPbJiivUASMnbav+aVwIgW3HCozqOvEigj35ygHB7GVi3
	hinlrTu5mr8mjgDqNwKw8A7cAqaUZWbxgJjrJaG/HfCLXdsKZsMowEcQfeDo7vCEwk7/OzD6cAe
	KyZV1FLRFGJYgy2JdZzPwc9T5UC4YqyoKaprOM/Uvm+NkR02jHyKgKp7+rKfsU7uMnHhhKYAseg
	3RvO1u0+n5T6iNBpAJRQR2zG+hYwV/G00AVTNYXhHkd6v0GVqPquRNCoVbemQbM7jmn/D3SmqHG
	Fna80yW6exa75pAXOziJ7iabgj8xO3LVZCrG/sDouZnxh9K9Gj2HdjFyHoA7wAD6jRI0HEQIsou
	KuGyvC0IGbszE52yqW7P5XV/TWSjCw0gxyZLPEtdQ0juZHv3ClQCashG9DrTKj1o2g==
X-Received: by 2002:a17:902:c410:b0:2dd:b442:ea48 with SMTP id d9443c01a7336-2ddb442ee33mr9125655ad.19.1789701840460;
        Thu, 17 Sep 2026 20:24:00 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c286d98e7sm591096eec.9.2026.09.17.20.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:24:00 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf: remove unused empty help-unknown-cmd.h header
Date: Thu, 17 Sep 2026 20:23:53 -0700
Message-ID: <20260918032356.466938-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tools/perf/util/help-unknown-cmd.h has been empty and unused ever since
it was added to the kernel in commit 5feaac248a46 ("perf tools: Move
help_unknown_cmd() to its own file"). Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 tools/perf/util/help-unknown-cmd.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 tools/perf/util/help-unknown-cmd.h

diff --git a/tools/perf/util/help-unknown-cmd.h b/tools/perf/util/help-unknown-cmd.h
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.43.0

