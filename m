Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3141775;
	Thu, 21 Mar 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034184; cv=none; b=K7vToygQEPPVSStSQhOrm8M2XDsVpzLH9O4Ed7ODxZYS0ODkwP1c5yATM244RgTLCR3kYk5f43xL4CBW39SuoZU+XNT1bmJ5aYZa9KJnGc/7TRlOIq6B0qTkAdbR6DB2a8K6YNAvEwJtdCGkM7GHbHxc1sZIxaX7P6MxdDJt0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034184; c=relaxed/simple;
	bh=iF7NrqB4wz5FwArmk3HMWgnVKMhNBp4xGE08oZ2rP+4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mYcd15RCRQEDXWu5isZ5vEvWUdUjsDUwOxWTER4i++un7oUdauaE2OBr0avgRPnwzq1cg2ST8/z1OjURAiqt6td1MH+LT4addxNvs7qd2U4u5Wk+qBze+ajMcZgt9n+Vk4Urd3qW69wUbDlRIlN7/8iLqWtW6eVOU0V5MQ8J5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEy0L+9S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEy0L+9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45DCC433F1;
	Thu, 21 Mar 2024 15:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711034183;
	bh=iF7NrqB4wz5FwArmk3HMWgnVKMhNBp4xGE08oZ2rP+4=;
	h=Date:From:To:Cc:Subject:From;
	b=CEy0L+9S9X+LGY3Kwjssm3s2KwThAsWYZjKlASxB8NADs6dtd9Okvk3CWSo8zmB7e
	 Qr1qqVhXplMw59QsZ5uX9fCh/xpxY+d14rQWVnnO7xBuWuXameWGa6mfbRnaPUX0Te
	 SaCl0qGgnSBA9NEAFlnI4IwKfNmMYVlv70Hpj8SoHrdc6R8IX1nZHwtZGQf1jU+Ebt
	 F/OmoF6gZCYG68/4V2pvvHSCWqV5RZalajO9cWx+ZCioKCvspNr8T9mP1eLiltw6Ii
	 mWBQcGUBs85nodDCxbm3hTV5tphlIEuyw/+f+wxbPwE8It2MitjghDcf6lmsNF7vzH
	 oEpacuKzkVtPA==
Date: Thu, 21 Mar 2024 12:16:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] libbpf: Use (uintptr_t) for a u64 cast to a void pointer
 to fix build on 32-bit arches
Message-ID: <ZfxKeSF5e6mXpnrs@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Noticed on several perf container builds:

  perfbuilder@number:~$ grep -B1 -A2 "cast to pointer"  dm.log/*\:*
  dm.log/ubuntu:18.04-x-arm-libbpf.c: In function 'bpf_object__create_maps':
  dm.log/ubuntu:18.04-x-arm:libbpf.c:5355:24: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  dm.log/ubuntu:18.04-x-arm-     map->mmaped = mmap((void *)map->map_extra, bpf_map_mmap_sz(map),
  dm.log/ubuntu:18.04-x-arm-                        ^
  --
  dm.log/ubuntu:18.04-x-powerpc-libbpf.c: In function 'bpf_object__create_maps':
  dm.log/ubuntu:18.04-x-powerpc:libbpf.c:5355:24: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  dm.log/ubuntu:18.04-x-powerpc-     map->mmaped = mmap((void *)map->map_extra, bpf_map_mmap_sz(map),
  dm.log/ubuntu:18.04-x-powerpc-                        ^
  --
  dm.log/ubuntu:18.04-x-sh4-libbpf.c: In function 'bpf_object__create_maps':
  dm.log/ubuntu:18.04-x-sh4:libbpf.c:5355:24: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  dm.log/ubuntu:18.04-x-sh4-     map->mmaped = mmap((void *)map->map_extra, bpf_map_mmap_sz(map),
  dm.log/ubuntu:18.04-x-sh4-                        ^
  perfbuilder@number:~$

I think Namhyung mentioned as well on a chat conversation about noticing
this on a 32-bit build on Debian.

Fixes: 79ff13e99169ddb0 ("libbpf: Add support for bpf_arena.")
Reported-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/bpf/libbpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index efab29b8935bd9f7..af0b0e24978558f8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -14,6 +14,7 @@
 #define _GNU_SOURCE
 #endif
 #include <stdlib.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdarg.h>
 #include <libgen.h>
@@ -5352,7 +5353,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 					goto err_out;
 			}
 			if (map->def.type == BPF_MAP_TYPE_ARENA) {
-				map->mmaped = mmap((void *)map->map_extra, bpf_map_mmap_sz(map),
+				map->mmaped = mmap((void *)(uintptr_t)map->map_extra, bpf_map_mmap_sz(map),
 						   PROT_READ | PROT_WRITE,
 						   map->map_extra ? MAP_SHARED | MAP_FIXED : MAP_SHARED,
 						   map->fd, 0);
-- 
2.44.0
