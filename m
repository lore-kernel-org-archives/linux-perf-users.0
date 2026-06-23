Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2863A961B
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192940; cv=none; b=H1H+qKO2slHSTRmQp2lqkzO6AvPzC445WC+V2vV56KYNYlbcU1rzUgL+Jan44ZLU7Cd3egG/GnjkxahbQOrEiaBMXflDFIQfXi8BVBkpLjniY3+nAgs9N/MMMvgyD+SS4/4pVNuGIczw14pk2ZCmwiYiwqiav+cF/YDTo93MelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192940; c=relaxed/simple;
	bh=BbUouOHmI4EMqhApuLX2WvLmovOe0WVOORDqWYarG1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cqhcEZoPyLDM0gL7mbuBbAukA7buZHn0U6dQ4MaXkUqCzxBxmadr73TIAky1FrEe33jlF2RNC/y5M4MmycetJJuZjPTnF+Vp95uQ9SoGbnovvOwdEle39GdXstVLbNS86Preqm53gnWAz2ynXopYosmS+OwcYGJr+PGXPLq9xG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ezEVIDZc; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ezEVIDZc"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137fe4a3640so7024233c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192938; x=1782797738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=doIaMLEu5kLEU0NjfednT9dLYxmCETOQdr1ejlkBeVY=;
        b=ezEVIDZcFo/XP1V94MM0nH0W47X03fqHKF9UkXj6TqoS71cFUriaG8RaW6wC80Pz1d
         oZfKfYHJuFfMN5XrOLzBj2s0q53meKtIALoSA7iKz2Pdcn9trbsxZPYXVFEw8w4BQoEs
         h4zuH6cApuwfH7rlHxek1qe7CuaMYLLsTIRp4OdJDT84M7iXkoCc8ZiLzcbWdZp3I/J8
         QqAm+0atA7aNLiuu5HRuoDk9kWtB1CfSKp3Jhc/oSlacxRUV6aEcbI3XOknebPVGsa4R
         DH1tPyGe66TmwmxVQXSLEIr6ivEx14JoBTryi13Mb3NbNbfFzvfXP2HGm2hL7WtZFZxr
         RlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192938; x=1782797738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doIaMLEu5kLEU0NjfednT9dLYxmCETOQdr1ejlkBeVY=;
        b=bsQoHQzSoX5vZKpMnCby/fYSXMbG4kGHMFnUzZu/KCDyyUjoDMPemJ2dX13hq5YhjM
         lkLpImwTVJn2b0fSTd8GW4dSue8Yld7jivCtr3iNxrvz6/0AfwFxhi2s7K6tk4lcaT9S
         tcToELKZvL58tUT2REGeXusL6CybjGBQdwnQyCsKEcq3aFfYYKi0T/lQOGgAr1gGP5vH
         0RZmoZOdEeefGQqXexQTUZFAruzgzXHh4vScv1ONxgngGfSW4vJwMLhUt4naPdrerjn1
         rarVbOJNBmsX+uVUKeZ0p2MP0qogUdyQrGoJR/dS3gnMuwoHrPE3/Ohpb4ewRbrXTvfB
         7aJg==
X-Forwarded-Encrypted: i=1; AFNElJ/9BX1Uo/Jztnzy97iFBZkCGcjGn2j09qcZVZvMLM8+G2REGK+jXXsWf1sMvuLi+doE8Qr3R19hl6NB1F/kXRJ0@vger.kernel.org
X-Gm-Message-State: AOJu0YytmULy7mMCXWnl6Byb/WcXIxXFDXNuEIosiEWULm08gf1SNNsV
	NVOQN/Rn8tcgcvUyZ6oB80pdGJ+CYJnptFln8qz5ogQT7X2ILFtxCSCz1PreYK/1NUH+tcbVAsa
	m29ynq+Mm9A==
X-Received: from dlep20-n1.prod.google.com ([2002:a05:701b:4594:10b0:135:5a9c:4291])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6894:b0:137:e6a9:b998
 with SMTP id a92af1059eb24-139a38812ccmr10352770c88.31.1782192937956; Mon, 22
 Jun 2026 22:35:37 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:06 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-5-irogers@google.com>
Subject: [PATCH v1 04/13] perf python: Fix memory leak in pyrf_evlist__get_pollfd
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a Python list object leak in pyrf_evlist__get_pollfd() by adding
a missing Py_DECREF on the error exit path.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 877108e42b1b ("perf tools: Initial python binding")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 11e1f39c1bea..21e8b5a23a1c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2843,6 +2843,7 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 
 	return list;
 free_list:
+	Py_DECREF(list);
 	return PyErr_NoMemory();
 }
 
-- 
2.55.0.rc0.786.g65d90a0328-goog

