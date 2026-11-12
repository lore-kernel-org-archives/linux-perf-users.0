Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504768;
	b=GSuLOEyQ5KpQkgLA4Ji/dbQrQO75YzJepzZ34x5+B7CyuLD7rRa71fK9ocDPzw0QWUTE
	 WqGNRdqDzoISZIjhB8TXas7X27/AxGnDiHjkOTFuTgoAY6n6okNmP8oLEz+8M23u5jNHv
	 MOyByf92P+vELIqd9wW3G6YFPJ1Ruc1HrfP8FqWVeZMdvLUqtcAVN/3kdDHaZGxvA+62V
	 w1bYUHpf6nIVI9VT+X1lEfshDL5WG4cWDpcz37HmZlkOXDthigDCWEeLaW/R9LnGvt144
	 JGirDey/dbc3KD1SqAN9OR8JyR63+2vgZFtupRM5IoV2uMXxfOhobTKQRq1mCZd1gXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2P7y66CJkgPkQFRhmo0DMWA/bXlScTLG8J7BrBYV+lk=;
	b=RI+uhGzqZATJoGdhMYEgXLAehhL5HZ3oWyZjHdnh2W5C3uYGvj6dyMRlEGMNClDqWR7S
	 V150zWFwaT+8sV+tezc2LyAFc7T1DVbd/sniM0zYkJIWM11WlGjPg6M3kDMexpaaYm87E
	 qPQrC1e5Lq5wK4q0iqImfhu4pKuKys6sNF5521nfkmxq3wctktSKcAmdzfANKlKOeNdZM
	 G/v2Nm+lTJrXnbqv5ns/Qn41tzDQbQZb/xrCU9+BGzIsS/xIqgH2PU5/KJumywfvCvhH0
	 hZIIRm7fylwA3BVSJoIyCpT+EG4dBqvgyMKaHEubg+crep8QgBdrkG4l9k9bDxHFoJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URrmeF5c;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2A606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 17:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69E2A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URrmeF5c
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-170135e43c7so3366604c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 09:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504767; x=1795109567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2P7y66CJkgPkQFRhmo0DMWA/bXlScTLG8J7BrBYV+lk=;
        b=URrmeF5c0SbsojMvZyjAMSTqt88/Qys43b6EJjLmH5dEEx2zb+zcRfU97xxR6rxy4S
         ORKgajaVa/Q8loV8yZnGJ92Mly42tP4X13cnbGxzgTMf4P5EOKtNSn4aHrlV4nXIowB6
         XRBpg9ehKPLzjnbSXumcW30h7Ow78enYGXc+jY+Npu8EbhMUuoDYN00I1rJWdny41sjl
         n4TKSMhdO9kWOO7bRAqJ/KVYMLY8CguyGwmGVQ4U9kx9cyCXMTSnlrM4ICYUkyH2Y6CZ
         aKqyT8DmJlJ1lipVuZYMFS0aTKN+AVGpXwU8ysYOibKQFCKa8AS9P9auLK65OFWuIT/M
         2V0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504767; x=1795109567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2P7y66CJkgPkQFRhmo0DMWA/bXlScTLG8J7BrBYV+lk=;
        b=1AN24d6t/RURsKgizNWRBkE2dobdQ6q63Ge1DU18pB7RjzY6jw8sH19AfnYQ3/wFtb
         8liceaka4rKhwaAUf87SDUaLa83xmAGETRnJLRfxO9DmmmVljEsjhp+eNGsHRjNDwpxn
         YU0sn7RzVcbtxYatBKRjgKQ3YZvRjZcxcOLxIjwo5iRVG7litaQnXc1Y4tc1qJuHRKw0
         jlLnlxWBHpSlRzVWJXqST16xWdXHBLVLO2yP+z0yqzK8ERPP7cbBRgtiGWQO+TKgk9l8
         TXN8MrhUfNQ/AvUQD98Y2aqkZfcVl5faJnFuAkafT58xmRms2gVmUwptan+9XCLtuXWs
         /g7g==
X-Gm-Message-State: APuU4Z9IZRxpx6JyCJ+cXvsDhA6FGCWqoIlsBWY4BLxvN+RimggmH+on
	ObG0eQgC0nfiITI3I2+/QoqvOQOPAIydZHSRvRVrjTWzO7J2w5Zlq70mrsrT9/4n
X-Gm-Gg: AYBFou2t1zINJqVXOe+eLu+z3CZyoECTGWRXFGji12hIrDb3G4acWMeUy16G0Makbye
	c9U6uQFsQsiUEof4rL064bj7qzmUoNT2YOC/1BHBfbYyNxKCaV9H1Agxu1IKactE11jmwCJEucC
	HsiDj54JZpiguHdi9oZnygflYgVaqX5SmyoCrkGlVhA+8qBaGoatBChQpwZfGMeiXwYGPaGN/mI
	hnJPhGhOFmLzpHvP5TqEeglR6jZsArM1EqD6NfWCzkvOi+3SBIzskYZvMXxvHY8IN/uv1KRTvRF
	iWuVJwPrPyfBZEcokNs3ZDtNVF7MD0XsIAOapk81+X2M4wxFwmCMJH+5CgJjJ2DpdGC87SjiZfv
	RAPkRgpRpFEt/wsHu4eW0c+/6KnMyMEe8PCi1XncuQcq1ss6F52X7PQThMOUd5MvAtJebAkPeoj
	zgIpfGF5ooorXyygKluGZerHo9ABA31Ul7eVuRlwD4q9M71XkPGfW9tFcfoOw5WPSDAJRE98C/k
	5553Hp8vZkIw4PfVt6WNkgFX2iuwCgD3WI1xuwlzmSdpESsnGqO7AA8PT/hhbrT60kTXKAFe685
	ecOAVJfNEEFtGKWOXnk0PBnXjOnPInCQsxh4I0tYDg==
X-Received: by 2002:a05:701b:4248:10b0:1b3:b455:93db with SMTP id a92af1059eb24-1b503131b06mr213096c88.24.1794504767334;
        Thu, 12 Nov 2026 09:32:47 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e008sm379345c88.6.2026.11.12.09.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:32:44 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v8 0/1] perf jevents: Check the keys of the JSON tables
Date: Thu, 12 Nov 2026 17:32:40 +0000
Message-ID: <20261112173241.197996-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112162823.139419-1-takano32@gmail.com>
References: <20261112162823.139419-1-takano32@gmail.com>
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

v8 of the check.  Two things the review found are fixed, and one is left
alone on purpose.

  - --check takes the directory to check as its own argument, so it no
    longer needs the arch and model the generator takes.  The test calls
    "jevents.py --check <dir>" and nothing else.
  - the test takes the interpreter from PYTHON (python3 by default) and
    exits 2 when it is not there, the same way it does when the generator
    is not installed.

The check itself is unchanged: walk, set difference against the list of 51
keys, print the file that carries the bad key, exit 1.  On today's tree it
reports 19 keys in four tables:

  arch/arm64/ampere/ampereonex/mmu.json    PublicDescrition   16 objects
  arch/x86/amdzen4/cache.json              BriefDescript6ion   1 object
  arch/x86/amdzen5/load-store.json         BriefDescript6ion   1 object
  arch/x86/amdzen6/load-store.json         BriefDescript6ion   1 object

The third point was that the test checks a temporary table and never the
tables in the tree, so a misspelling could come back unnoticed.  That is
right, and it cannot be added yet: the tree still carries the two
misspellings above, and a test that fails as soon as it lands is not one
anyone wants.  Once the patches that fix them are in, the test can run
against the tree as well - I would rather add that as a second step than
bake a list of known-bad files into the test now.

Changes since v7:

  - --check takes the directory itself; arch and model are not needed
  - the test uses PYTHON and exits 2 when the interpreter is missing

TAKANO Mitsuhiro (1):
  perf jevents: Check the keys of the JSON tables

 tools/perf/pmu-events/jevents.py        | 41 +++++++++++++++++++++++++
 tools/perf/tests/shell/jevents_check.sh | 29 +++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

