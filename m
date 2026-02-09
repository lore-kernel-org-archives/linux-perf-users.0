Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F53382D6
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668535; cv=none; b=cni92aEjT9ioL569ahGHj7dwC0PYYzdonLguscs0XDLLTmUK9jYNdi5aFrXtvGNJOVVwYd+yvno4Pgx7FA/owye0qCzYjHXILfP/flExKUxrtS+a3NMNyHkMt1G46i4ivagEEsQkilOS8rJASM1wNFkl2t+bxqfrCmtwm+Bzluc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668535; c=relaxed/simple;
	bh=Ui/SugiVmcRAov8tt7/adCmjGYW1ScNgh0Y3uPIDkF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZRbgfGtixIY3Hia9+oouDplrV3Mf6W7IqMlN2u8DkYwMSpI1sKNAgudfyYhkLKIDSZRruyziNxvyzh8kaa4flXzzcNqquiJWwOTg85pYCE8NIaD4W6VUnhe3agDBKS6Mkw02E/uqBEsGX9DNugfyhM+9h2k5Fj6ps61cqvlnS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RIHqp01x; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIHqp01x"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so83392c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770668533; x=1771273333; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0daziDUtL2ibgI5WtkZQDKzcSzE6a5XxpXzSEtLh90=;
        b=RIHqp01xMw0CKXnUwhwekkv+fvTer6yLvlaE91cU+3sMApi2wa8oKtZAN4RI7DhAZy
         sv+Myh8ZEA5s1DuoSHXK1SPG8drknmHizTCIA96pjXm+Ht4/Jbo+fclvGKJBwPp1Phr4
         X6bkgHmW+NKZyapK6ohbY06YmpeF1l/8rGAhfa4GDnBwBUSfx0hO8S8hdkfYGLuNt+xt
         5h0iLwDLnx1IRNIf/nT3kjIcwXYBQexZ95WbXcXIL2aa9zUIKiHn3diaYUKm+fOzaO4H
         K4YXRB66rIjzO61bSmf2xwiW624+xlkB70iuCpTLp1lFN/k1/ggp/FBiEDQPy9cs05tm
         BU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770668533; x=1771273333;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0daziDUtL2ibgI5WtkZQDKzcSzE6a5XxpXzSEtLh90=;
        b=YpFnz8ZQQRtMvH9BMhdCa1z2jhp+pJK5nTQyciY0LbJ1YvEmdj3K24Boysi7hHbjJy
         jwSWRFZpt6xzSeVRqjGv8+bMmePzgn6gWz2rZaGIagHj2B3gJzvHEc2CN6EVH4kQJg8m
         jh1gdXvtEk7gRMHkLi2glXZAoZTU87X0T0RnFoXqimnThiv8KREUyE0noKWJq6lFr11A
         YND6sa2bgjOwEC/pNbXxD197KhrW1zkQNn5FbGOMStLV6CpcuLuoPBuOM9m9p3Ls31sv
         sngm3DjxdHZSa34DzMbnpx2KuDYweGyUsRRur6m0MFNbRtlineMh+59VgdKIKuQsyWs8
         ZicA==
X-Forwarded-Encrypted: i=1; AJvYcCVqIjoQP+qlNCHLzm9fi6HaZzg0nS+nkQVUfInlHq6JXQUdKzy5FM1ylj1lrMJ3HF7MyhtqRA0l9cIUTN2SK8YZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5udiNMb10pWGryobkxc28uNpYPvfN/jjszndouu15/qEdQoxp
	rc6/fiZ88MZnjZ2xa5tV0QkqNg8Q3BlE1UPHSw3omCqp881xUfn8pLWqOJPJp7pn0HvVlNqBW0o
	dKKobrbWM9Q==
X-Received: from dll39.prod.google.com ([2002:a05:7022:227:b0:123:2708:9404])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e22:b0:11b:8b4b:bff7
 with SMTP id a92af1059eb24-1270409535emr5362949c88.39.1770668533318; Mon, 09
 Feb 2026 12:22:13 -0800 (PST)
Date: Mon,  9 Feb 2026 12:22:06 -0800
In-Reply-To: <20260209202208.2027001-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209202208.2027001-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260209202208.2027001-2-irogers@google.com>
Subject: [PATCH v1 1/3] perf script: Allow the generated script to be a path
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sandipan Das <sandipan.das@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow the script generated by "perf script -g <language>" to be a file
path and the language determined by the file extension. This is useful
in testing so that the generated script file can be written to a test
directory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-script.txt |  6 ++++--
 tools/perf/builtin-script.c              | 24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 03d112960632..ddf92f9c7821 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -98,8 +98,10 @@ OPTIONS
 
 -g::
 --gen-script=::
-        Generate perf-script.[ext] starter script for given language,
-        using current perf.data.
+	Generate a starter script. If a language is given then the
+        script is named perf-script.[ext] according to the
+        language. If a file path is given then python is used for
+        files ending '.py' and perl used for files ending '.pl'.
 
 --dlfilter=<file>::
 	Filter sample events using the given shared object file.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 14c6f6c3c4f2..7c743a303507 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4489,6 +4489,7 @@ int cmd_script(int argc, const char **argv)
 	if (generate_script_lang) {
 		struct stat perf_stat;
 		int input;
+		char *filename = strdup("perf-script");
 
 		if (output_set_by_user()) {
 			fprintf(stderr,
@@ -4516,17 +4517,32 @@ int cmd_script(int argc, const char **argv)
 		}
 
 		scripting_ops = script_spec__lookup(generate_script_lang);
+		if (!scripting_ops && ends_with(generate_script_lang, ".py")) {
+			scripting_ops = script_spec__lookup("python");
+			free(filename);
+			filename = strdup(generate_script_lang);
+			filename[strlen(filename) - 3] = '\0';
+		} else if (!scripting_ops && ends_with(generate_script_lang, ".pl")) {
+			scripting_ops = script_spec__lookup("perl");
+			free(filename);
+			filename = strdup(generate_script_lang);
+			filename[strlen(filename) - 3] = '\0';
+		}
 		if (!scripting_ops) {
-			fprintf(stderr, "invalid language specifier");
+			fprintf(stderr, "invalid language specifier '%s'\n", generate_script_lang);
 			err = -ENOENT;
 			goto out_delete;
 		}
+		if (!filename) {
+			err = -ENOMEM;
+			goto out_delete;
+		}
 #ifdef HAVE_LIBTRACEEVENT
-		err = scripting_ops->generate_script(session->tevent.pevent,
-						     "perf-script");
+		err = scripting_ops->generate_script(session->tevent.pevent, filename);
 #else
-		err = scripting_ops->generate_script(NULL, "perf-script");
+		err = scripting_ops->generate_script(NULL, filename);
 #endif
+		free(filename);
 		goto out_delete;
 	}
 
-- 
2.53.0.rc2.204.g2597b5adb4-goog

