Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D7524F;
	Fri, 24 Jan 2025 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737723984; cv=none; b=njk6b6tbgVoXvGZo0XTUhYtNzapFfLy30aQRg17wubI5dzkJRumBEFA9TQnga30aYhLj812TbQciEspBU+J6px1qNZXOunpGP11FZgSDTXKZ0rAQ1gOxWJfG3pGWgQYSv0S/gfGskV6jUvJdUs4afULfMWFcybQFWY8OYYHTbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737723984; c=relaxed/simple;
	bh=UtK+nhBivAECrcz01AvU9HgssHYlHdSg2R4PFGxj0GQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kAL2AcPnqGSDVbz4hP/CiG52kr0I0Mhc4FeiC2ktsO8BPyeC41siK8O44ycqf3seWOxxpKMAco+6plzZR7rbe+bMD+eBBYbxp/BoyCOTV7bsZU2XMHI9hjqRRQMX+/OOMXFQrv73RfreSJIDO5YWc6Qsh23wBxa8IZVp6uhlnmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z0YQnuIH; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z0YQnuIH"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8864E1C000D;
	Fri, 24 Jan 2025 13:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737723980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Gx9Q6arUZX8SVRBG8olJbsdUmjOfiNx9FL8MZV78Yc=;
	b=Z0YQnuIHXJkmG76ip8Zbbr7G7IXmQNV7udo5Ig+JliipLgZYe6FKtFxrSXGiXct3af9AYZ
	kGDAzyAVEgK+s1r6Nlp6iFFVifgTu1nCxSqrXdgHmZLD0wahzH4qi/xUVSqMOniQLKkKkC
	bkkeoiDYsaQzAqefgUYCjPYgRSR6K5Zu/IJ9dyiJnj2U6YWV7Npf3LU6L91LLL/HKFzy6l
	3EY0vRTAPfb2ZmonrcFs6pkPB7BKH148Km4yI6r3AiBfnI6M8z0XO+Y1ECJ461Dgfaq9K6
	rra0XuCfGc352zJMBGSAdU9JcB/MsaA3g1vGhAaEdCfZX5DSj+6c401hfGsm7g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 24 Jan 2025 14:06:08 +0100
Subject: [PATCH] perf build: fix in-tree build
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-perf-fix-intree-build-v1-1-485dd7a855e4@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAD+Qk2cC/x2M0QpAQBAAf0X7bIvLEb8iD7g9tnS0h9Tl320ep
 2YmQSRhitBlCYRujrwHhTLPYF7HsBCyUwZTGFuUpsKDxKPnBzmcQoTTxZtDP7m28bZWqwJtDyF
 1/m8/vO8HnRgxm2cAAAA=
X-Change-ID: 20250124-perf-fix-intree-build-fbd97f560254
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: luca.ceresoli@bootlin.com

Building perf in-tree is broken after commit 890a1961c812 ("perf tools:
Create source symlink in perf object dir") which added a 'source' symlink
in the output dir pointing to the source dir.

With in-tree builds, the added 'SOURCE = ...' line is executed multiple
times (I observed 2 during the build plus 2 during installation). This is a
minor inefficiency, in theory not harmful because symlink creation is
assumed to be idempotent. But it is not.

Considering with in-tree builds:

  srctree=/absolute/path/to/linux
   OUTPUT=/absolute/path/to/linux/tools/perf

here's what happens:

 1. ln -sf $(srctree)/tools/perf $(OUTPUT)/source
    -> creates /absolute/path/to/linux/tools/perf/source
       link to /absolute/path/to/linux/tools/perf
    => OK, that's what was intended
 2. ln -sf $(srctree)/tools/perf $(OUTPUT)/source   # same command as 1
    -> creates /absolute/path/to/linux/tools/perf/perf
       link to /absolute/path/to/linux/tools/perf
    => Not what was intended, not idempotent
 3. Now the build _should_ create the 'perf' executable, but it fails

The reason is the tricky 'ln' command line. At the first invocation 'ln'
uses the 1st form:

       ln [OPTION]... [-T] TARGET LINK_NAME

and creates a link to TARGET *called LINK_NAME*.

At the second invocation $(OUTPUT)/source exists, so 'ln' uses the 3rd
form:

       ln [OPTION]... TARGET... DIRECTORY

and creates a link to TARGET *called TARGET* inside DIRECTORY.

Fix by adding --no-dereference to "treat LINK_NAME as a normal file if it
is a symbolic link to a directory", as the manpage says.

Link: https://lore.kernel.org/all/20241125182506.38af9907@booty/
Fixes: 890a1961c812 ("perf tools: Create source symlink in perf object dir")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d74241a151313bd09101aabb5d765a5a0a6efc84..bbd799a0fd544db220f29d1e250a819a765d04f3 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -164,7 +164,7 @@ ifneq ($(OUTPUT),)
 VPATH += $(OUTPUT)
 export VPATH
 # create symlink to the original source
-SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
+SOURCE := $(shell ln -sf --no-dereference $(srctree)/tools/perf $(OUTPUT)/source)
 endif
 
 ifeq ($(V),1)

---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250124-perf-fix-intree-build-fbd97f560254

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

