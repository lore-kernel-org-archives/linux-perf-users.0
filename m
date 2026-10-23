Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761635;
	b=2iEIlmvjCyxPGk8JS8SKPBLxfaS1PWKe/6s/K6bcvOzNCElr2Q0TicgNGXz/qPfxncwM
	 kAE3rvxJNIbUFW0Do/4KW9Ta36YuB9wBgK3yAOPVFJpziGTzf6/5pPk+2MEdgR6Z1pnGm
	 GhNi2+xec1hp9AIeQ72e5IJ9uHIeUEHrhoEumpxU7a3J2fOfYIt5PIeeFkk/+I0NVKQIT
	 DB9OasLnu/DV9PkjurqW+aNZ2TaqCAZyr0ABzEmEhmX9hSIXR2npF2N5+bZeZQM+LXY+o
	 qR+Hjs8cqSWiD4RW0bybIzkBh5L2tmgPg9YqoQWW25AvpUlBCdgF6n6rP2jXUsn6GLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761635;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=x2+lerSKmrMO1IfBPVY2HDNjLRSI8OfAuqS9N5027NY=;
	b=IV832lsWcw1qonc84MbK6Smz6EhDaCuAGzqztwjU5mqL5v1L8j2b0LqDa+0dGRYkIUHy
	 iSDOO5sAprkju2lIZjuoH+gxB+ltxFeBtswOJbs3I8jQj6PwbVE7EMpc2xEBFk5YPH/w0
	 YOS3f4/L65EhdWS+zQs32mk46q78d9fMawLBRniPJpE3pLRmfk6ML3hvKTFxBZlZY23m1
	 ikndYS8J8zL67jmAkHt+Qh+dqFIIunbWOMaI0/QF3eYBjn1/KogMG0smDLquComhZDfQW
	 8TSoTxCicbnZM3rmKCOqcge5yCYlRp5vtHa3GvPTwzVII14muzfpPtqh8lJi+42NLdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=q7DHE4iV;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED83606A31E;
	Fri, 23 Oct 2026 13:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AED83606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=q7DHE4iV
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB3E3328E;
	Fri, 23 Oct 2026 06:20:30 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 252373F673;
	Fri, 23 Oct 2026 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792761634; bh=ejdoYmnyIZh8lNqNPhDsSb3POusRYMhf8j68j5P6Z58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q7DHE4iVh0PVgx+/TMLAGAf+7obyHcM6Q6D8G9mO5atbe/8FXGd8C2ItS4VoYEQgS
	 3E3s/l5eLeP1UClQut7jw8QydY3XRRJ88aVERmxQClyOZG0H3AnTBLa55IurC0WwW9
	 O/mgAb7voYgst84DaUNwnBm/VNuxS9RlfSRMu+0E=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 23 Oct 2026 14:20:24 +0100
Subject: [PATCH 1/2] perf treport: Initialize the subtitle in the
 constructor
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-perf_fix_pylint_warning-v1-1-b9da8dae2fe9@arm.com>
References: <20261023-perf_fix_pylint_warning-v1-0-b9da8dae2fe9@arm.com>
In-Reply-To: <20261023-perf_fix_pylint_warning-v1-0-b9da8dae2fe9@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Alice Rogers <alice.mei.rogers@gmail.com>, 
 Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792761629; l=1984;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=ejdoYmnyIZh8lNqNPhDsSb3POusRYMhf8j68j5P6Z58=;
 b=eGW4ZbxL/sxvGnH2vIJ+o7tXDnIOgiZOnGPoxoEU2bu6nUJI+Eb1pDvfHeLp4UBFdJ7OfRgk/
 jTFsbwz0a2rAIzF5slASMJPpQumBpTkTl0qW5mSgmgv8HDuYMGXXg8s
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

For Arm64 cross build without Textual, assignments outside __init__()
trigger pylint warning:

  ************* Module treport
  python/treport.py:625:8: W0201: Attribute 'sub_title' defined outside __init__ (attribute-defined-outside-init)
  python/treport.py:629:12: W0201: Attribute 'sub_title' defined outside __init__ (attribute-defined-outside-init)
  python/treport.py:668:8: W0201: Attribute 'sub_title' defined outside __init__ (attribute-defined-outside-init)
  python/treport.py:675:8: W0201: Attribute 'sub_title' defined outside __init__ (attribute-defined-outside-init)

  ------------------------------------------------------------------
  Your code has been rated at 9.91/10 (previous run: 9.91/10, +0.00)

Move the initial subtitle assignment from on_mount() to
ReportApp.__init__() so pylint can see the attribute initialization
without resolving the Textual base class.

Fixes: b379b70b7b7b ("perf treport: Show the profile while it loads")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/python/treport.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/python/treport.py b/tools/perf/python/treport.py
index e021214753707780343e79dfc6964b9c69698197..f8c95ac1c6e067e8291eed59530f31c77886df68 100755
--- a/tools/perf/python/treport.py
+++ b/tools/perf/python/treport.py
@@ -602,6 +602,7 @@ class ReportApp(App):
         """
         super().__init__()
         self.input_file = input_file
+        self.sub_title = input_file
         self.root = root if root else ProfileNode("root", parent=None)
         self.loaded = root is not None
         # Held when reading or changing the profile, which is built in a
@@ -622,7 +623,6 @@ class ReportApp(App):
 
     def on_mount(self) -> None:
         """Start loading the profile unless it was given."""
-        self.sub_title = self.input_file
         if self.loaded:
             self.update_views()
         else:

-- 
2.34.1

