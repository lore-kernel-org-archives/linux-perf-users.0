Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03D33168E6;
	Sun, 26 Jul 2026 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109230; cv=none; b=V7NRvggakTujg2NDX32eyEqgJwXrzO0l+pRdJ4snxUbVMXxjDc8v+TO5gdKiDxdTqP7o5F2bRlpB+ZxLx8YGcFGdN190s/DsIBeFovFg81z30k1qZSZDaLvD4ebrM9onMjxNHfhqFLv/ixgHQw41Cehx/pCRexNv++PaqsoRF0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109230; c=relaxed/simple;
	bh=/Er3l6Qz5SOIcYE/tIlmE5Nu+ff3oHT9i5oi0I8SKOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTl95LIHYby/m/GSY8DH9NKgfW+TWWVUiJfJA9M7vHBzze/t2I8oOwZLVl1B+iymX/sv5oFgYr2VSIVYOV0FrykUIaokvF95TJomHnYOPSXBWi7SJCWqbEnK2XSAbfdeCKtfBi08KkMmw1KzCBMU+TMzXE5NJpxBAAxnWRdjlQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjprPLB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjprPLB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36821F00A3A;
	Sun, 26 Jul 2026 23:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785109229;
	bh=rPKCvy7pByKaBZI9xeruDtZEEDUt+hCJ5pHdBwPU1Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VjprPLB/0LKQoVB95F7BTMHqPlzMWTwkYkyBDpiBR+fJ+1yiCpl9YmglWRkZavc+v
	 4BARPJeXPwmtIPjpgUDzUFVRGL952hCqu8I3+BdmUF331qhJ9Vac5femSEV9jtbl2p
	 ZnEjYha98j8Qs9TubHXKdLQIspee8WrdmdfZSM366GSV4eZ/07agCX0isLvYXrA79q
	 CARo34EXrlV2wGXJQHAl9JqG05iO8t9z4NfFzDpdlLgQyvbVkZi+QHWLCQraO6F3Fv
	 yKmVYIL5rkmbysPh3wDh4hOy6d81xHnqloU+DvoERZYIc95xrAU1BSGDzHl5RwkoT2
	 tgiW/FOUCo0jA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH 3/8] perf machine: Guard against NULL strlist in machines__findnew()
Date: Sun, 26 Jul 2026 20:40:09 -0300
Message-ID: <20260726234014.63111-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726234014.63111-1-acme@kernel.org>
References: <20260726234014.63111-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The static 'seen' strlist caches guestmount paths that have already
been reported as inaccessible, to avoid repeating the error message.
If strlist__new() fails (OOM), 'seen' stays NULL and the next call
dereferences it via strlist__has_entry() and strlist__add().

Guard both calls so that on allocation failure the error message is
still printed (just not deduplicated) instead of crashing.

Fixes: c80c3c269011 ("perf kvm: Limit repetitive guestmount message to once per directory")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8b213482e5648e97..baf855e596c267cd 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -340,9 +340,10 @@ struct machine *machines__findnew(struct machines *machines, pid_t pid)
 			if (!seen)
 				seen = strlist__new(NULL, NULL);
 
-			if (!strlist__has_entry(seen, path)) {
+			if (!seen || !strlist__has_entry(seen, path)) {
 				pr_err("Can't access file %s\n", path);
-				strlist__add(seen, path);
+				if (seen)
+					strlist__add(seen, path);
 			}
 			machine = NULL;
 			goto out;
-- 
2.55.0

