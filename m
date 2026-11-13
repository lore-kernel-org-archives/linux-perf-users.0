Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540572;
	b=ji1T4cc5RIbIZFynLgZqApLRmd8J0lq9FLW4txNMRKAuIScmKM1lwcKHH9MIhMIZcCmO
	 2y8LRqUhtJOLIopsC5k1hpvH7NDST+ecBybKqhFarUjWEUq5zr5nxseTrV0raLCziUfoq
	 QgKvXnV17g9MBuy6ni078aO5H+EOo2iKk98f2811vrqVksqUKuzykvSRFN843mCs8vcmt
	 ttrvaFOGgxdngpz3AxdY44phhCAfeV3Fd7tQ3K2VBK5OlqyT7AnAQeKhCB0BhpIAkOQsP
	 QucyAeRofz3IVWwJ3ZBPy0eXDFdkNTV05ExLa7LHLMKk2QanBE5kibcaadWVmBJNK7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OVVlwCCA1VOiytgWSOMQ1r/qQrP88cTuf93DDNf2J8A=;
	b=4ZBVlbRG0d8pwOOpqMXEvOC3bxstyLlWMR6eNhrd8hZAm2thH+BxJWupH2qwv+3y8OLO
	 51dcdWVRpI+7rKvPA7ESIgBggRZz1vmU1ESAmnr8zpcg1z1r2rSpcXOotRSEduUZUYdai
	 DReJaLkjhvq1xW6z+yr4HI/1oCSUfXwjHKrpzfYhRLavwOuxuAwk8Mcu78I3Sz5licDhT
	 3h5mK1z6/4frK5Or0d2Pec+nAvgamTfkeoZ2yP0x9DHYIm2wvd45KJ9YpFBZk9LLxMuLS
	 FypVthPheZk4XKjwKbpk1ntPETJOJFJaV8T+ufEWWQitWJE9cTMNfFXQ8w7XWMELdDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dN992MCG;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E6606A334
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 03:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D3E6606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dN992MCG
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a3c08d6928so604382c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 19:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794540571; x=1795145371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVVlwCCA1VOiytgWSOMQ1r/qQrP88cTuf93DDNf2J8A=;
        b=dN992MCG+OvBpBDmgo7VA3dzlSfiCqdsX8Wz0ia9pyk9zl7LjHHjgH16i5B2AS0qp5
         D4nK6dWWeFty+EXIAwto526zG3r5hekQvLPEa/jQDC5XxT1flZlJ9/0M2mJOboiNajE2
         TvCubp1dOR54H/1gjHeTyIm3gnYWXM2HIM57q+WRtibxC4J2Fc5OR64XYjsS/nrmcY7i
         hRblAnpA/Wq1SvVGWBdvkUn6asRKkwejOeUcDHFqskEkRJCQm1bRPicbOPEi9kHoCGYH
         nxg0Yw1MAsLD1bG/MftNfH0BdknaD0Y+VZQ0gZTfYyWTwKg2GkYbydggBuuFkX4z1U75
         NAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794540571; x=1795145371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVVlwCCA1VOiytgWSOMQ1r/qQrP88cTuf93DDNf2J8A=;
        b=Mhu6IVgE9Cm2l/FLolQQvwRKDHpkUBXiTaJqsmkGfYMZMlJ0mMChtymdPDkcaJR7va
         lRe54p4oFoXIHZ14hM0gNwH9BfiIg41N7yL0qAfJw47mnDbGJsyNa034Gy+MSq38+20r
         4t6abcUIYW47FSrLswrHGhk64cfwl5RAgLDDnOmEu66d/9KAuIGjijwt0DChgzH5NrOv
         HKahi/WiT5HztDs8jEDuXzbLxRdqOBmck6pU+kBmmTEZvt7Nb5XBkKwIY5OpvCE7cWWG
         dfY3rRk0TtzuDTEhkHSvrhCrHfOUqF8MWXh/oM9JoZvl19eoPVHEjG9q1XOewYTqIjk0
         cIQA==
X-Gm-Message-State: APuU4Z/LPy0MygHIOhAx/RL7kYOV2/fdEOLUIuYjsQD98TdWTvvkcBcp
	fCq0mb2DLO/jJF/mh9xXfkTxdeU7Rj9QHDs8THBxjHZGfjbuyXPQqGXBmwlm4g==
X-Gm-Gg: AYBFou1DIm9LNBC9S+qfzHGhs3f+jNDQWDT+KJxSGo3lL7fbxT7iNwzbWUN29YT4lqu
	U5ukaT+DbjvCx88wETA2LVQjfXkmvyehbfrY+EpCyi4/sXl+1LB9NMCeXZfn1u1T7V/AaHdYTzM
	Qq61bsg1I8mkdrH6e0CdWYdU0UW0qL3Lv+dFRpD1sP5naQq6vui6TDMSVqSNcIuJBkhIc+Du+rS
	D9MAM0kq1EGpbp8waQQPdtBCF5WvyTozXCiKoble1g1dbSnd/Vozo5kpzAo9QpDAgMEK9Zco68h
	a+x3tOagQ+YNIwcfMN9R2tcktc0IXCntaKRCFrZuOeklEKDlPoyJhePajqjWuN9qclxnW5McoHI
	9YCiTlDSZpqBW3KaSuTLEcWKv+KVqTRS8tXTPRzh6Zk5qD8+n27clMv1c/hYHjRFCbnqqK8Qhyu
	gAb39eEbQpMvuQSehLHTb7Pys3E1G3ynjUpoDxu5JH4axbNmsDkUh9NSzMI3q0+59GNtWprcKij
	7PDBG4xCPXXSpbNNMkFcauCJdlntxlEZ5yoZt2FZEcvCrIbrjd+axTzht/HLL9h+tugBtJi+xdI
	9XslqOKtZ4BbTEIIHk5I
X-Received: by 2002:a05:701b:4188:10b0:154:fa0b:6df1 with SMTP id a92af1059eb24-1b5030fb7f2mr1410187c88.37.1794540570881;
        Thu, 12 Nov 2026 19:29:30 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b27dsm3029718c88.2.2026.11.12.19.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:29:30 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v10 0/1] perf jevents: Check the keys of the JSON tables
Date: Fri, 13 Nov 2026 03:29:26 +0000
Message-ID: <20261113032927.634183-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112222526.462146-1-takano32@gmail.com>
References: <20261112222526.462146-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v10, and an apology for v9.  The two fixes v9 describes were not in the
diff it carried: the commit that holds them was made on another branch and
the series was built without it, so v9 was v8 again with a new cover.  The
review was right about both, and this time the code is in the patch.

  - --check on a directory that is not there used to report nothing and
    exit 0, because nothing found under it reads the same as a tree with
    no bad key.  It now says so on stderr and exits 2, which is the code
    the test already uses for "could not run".
  - "--check=DIR" is taken as well as "--check DIR".  The option is read
    before the parser looks at the three positional arguments, so the
    value could be left over and taken for the table directory.

The check itself is unchanged: walk, set difference against the list of 51
keys, print the file that carries the bad key, exit 1.  On today's tree it
reports 19 keys in four tables:

  arch/arm64/ampere/ampereonex/mmu.json    PublicDescrition   16 objects
  arch/x86/amdzen4/cache.json              BriefDescript6ion   1 object
  arch/x86/amdzen5/load-store.json         BriefDescript6ion   1 object
  arch/x86/amdzen6/load-store.json         BriefDescript6ion   1 object

The point about the test checking a temporary table and never the tables
in the tree is right, and it is still not possible to add: the tree
carries the two misspellings above, and a test that fails the day it lands
is not one anyone wants.  Once the patches that fix them are in, the test
can run against the tree as well - I would rather add that as a second
step than bake a list of known-bad files into the test now.

Changes since v9 (and since v8, which is what v9 carried):

  - --check reports a directory that is not there instead of passing it
  - "--check=DIR" is accepted as well as "--check DIR"

TAKANO Mitsuhiro (1):
  perf jevents: Check the keys of the JSON tables

 tools/perf/pmu-events/jevents.py        | 48 +++++++++++++++++++++++++
 tools/perf/tests/shell/jevents_check.sh | 36 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

