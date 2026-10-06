Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E649E13F;
	Tue,  6 Oct 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303211; cv=none; b=KcvJ4xs5WeqHBOFc5yFIJfub0TLjim6Y7Lc2gv0zA06bNyTqZ7T7qC2uOeUBX/kVaIFnUBkuJDwe3y/g8JE33oz5R0zxTz4Obb83MZ7mmBVRQEvGd7K0aDFQQC/udxK7z3WVfDKe9tXg9sjTCAaNLGwT+Wpm9inkyp/94u5lTSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303211; c=relaxed/simple;
	bh=aegR0NLKsPxDV0vFIN8/L7BW9R78ZBSi1BPYto6U9Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MayxyGzBwztpa1cJ2lws0GwyTE/Hnm3pFM+EGhCwoEiZ7XVNPn7SH+yq49FGtkEuCUglgyc/jzMG00bAkSvPj1lgRJ9Lgk97weM2pS5pgXf0Zhof64ijPeQFAnxEegcRuOPw4FvUu/nu3yqKnWXLu1O9UlTpft303RZpgy8esi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6pOcVA/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6pOcVA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9844C1F0089C;
	Tue,  6 Oct 2026 16:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303209;
	bh=5A0yVU0NRrL3FdvSxR8wayYapopEKMiwv0yNYzyuBXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y6pOcVA/DSuJhpOQL5Dn+JvRWV+kIbEfN890K5cSW4IVam0lYH1kR5deIqsD9xMAV
	 jZQKFKoBAjVk3IQMf7V0FD/OaYW1CtcZuLT0g9w4i8RP5Ng7ArMWwo/Bov6GuzzVie
	 9EemhwTSwiqV5ySMbYkqOnJaEln7nZ9AWkI5aZJE7bBSoAv5rwpCW3IpgWjNnqh0AX
	 W3a+cQtbkuP8WTTjhnSmRe3dpsKFaFIkMeuq3zt7BchOz44Lbl6vd6jGe7m2JwEsAO
	 ZP0jEcuLCK19wqVHmfpb5MaarICFuI+kuGkcZUrHLsc5Wkysaf3bSQX2NXX7j36ig1
	 v4adpQguuGLpg==
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
	Michael Petlan <mpetlan@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/6] perf test attr: Propagate the return value from the test to the wrapper
Date: Tue,  6 Oct 2026 18:13:04 +0200
Message-ID: <20261006161309.3078488-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006161309.3078488-1-acme@kernel.org>
References: <20261006161309.3078488-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Petlan <mpetlan@redhat.com>

Currently it does not matter what the python script actually returns,
the test always passes, as the $err variable is always 0.

Fix that.

Fixes: 8519e4f44c2af722 ("perf test: Add a shell wrapper for "Setup struct perf_event_attr"")
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/attr.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/attr.sh b/tools/perf/tests/shell/attr.sh
index 5a4e43b2471de811..307e1535795a34dc 100755
--- a/tools/perf/tests/shell/attr.sh
+++ b/tools/perf/tests/shell/attr.sh
@@ -18,5 +18,6 @@ trap trap_cleanup EXIT TERM INT
 shelldir=$(dirname "$0")
 perf_path=$(which perf)
 python "${shelldir}"/lib/attr.py -d "${shelldir}"/attr -v -p "$perf_path"
+err=$?
 cleanup
 exit $err
-- 
2.55.0

