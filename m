Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B42C433B4
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Apr 2021 19:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B752D61077
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Apr 2021 19:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhD2TR0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Apr 2021 15:17:26 -0400
Received: from mail.kdab.com ([176.9.126.58]:61040 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237985AbhD2THf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Apr 2021 15:07:35 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Apr 2021 15:07:35 EDT
Authentication-Results: mail.kdab.com (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=kdab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-transfer-encoding:mime-version:message-id:date:date
 :subject:subject:from:from; s=dkim; t=1619722875; x=1620586876;
 bh=Jy43Mhlk+EgDqIHE33V2YmBeSE9D6opQpdzPQljCMVg=; b=PqyjVlGZ1UAc
 HfoNED5VDRCDWKtwE9S9Libwu2lCsNLeyvardsbe9qD2WjJs7OuhJ7xRPyMRW3bp
 nBkR8D7ECLHmvbzpsHtwaBWgCtFJYkfji6VMm7YegxAMjysm7EQyjphMbXmYfM92
 F+EU8l6bLlkooQUltb6NUuCENJrrw7M=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     acme@redhat.com
Cc:     alexey.budankov@linux.intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf buildid-list: Initialize zstd_data
Date:   Thu, 29 Apr 2021 20:57:59 +0200
Message-Id: <20210429185759.59870-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fixes segmentation fault when trying to obtain buildid list (e.g. via
perf-archive) from a zstd-compressed `perf.data` file:

```
    $ perf record -z ls
    ...
    [ perf record: Captured and wrote 0,010 MB perf.data, compressed (ori=
ginal 0,001 MB, ratio is 2,190) ]
    $ memcheck perf buildid-list
    ...
    =3D=3D57268=3D=3D Invalid read of size 4
    =3D=3D57268=3D=3D    at 0x5260D88: ZSTD_decompressStream (in /usr/lib=
/libzstd.so.1.4.9)
    =3D=3D57268=3D=3D    by 0x4BB51B: zstd_decompress_stream (zstd.c:100)
    =3D=3D57268=3D=3D    by 0x425C6C: perf_session__process_compressed_ev=
ent (session.c:73)
    =3D=3D57268=3D=3D    by 0x427450: perf_session__process_user_event (s=
ession.c:1631)
    =3D=3D57268=3D=3D    by 0x42A609: reader__process_events (session.c:2=
207)
    =3D=3D57268=3D=3D    by 0x42A609: __perf_session__process_events (ses=
sion.c:2264)
    =3D=3D57268=3D=3D    by 0x42A609: perf_session__process_events (sessi=
on.c:2297)
    =3D=3D57268=3D=3D    by 0x343A62: perf_session__list_build_ids (built=
in-buildid-list.c:88)
    =3D=3D57268=3D=3D    by 0x343A62: cmd_buildid_list (builtin-buildid-l=
ist.c:120)
    =3D=3D57268=3D=3D    by 0x3C7732: run_builtin (perf.c:313)
    =3D=3D57268=3D=3D    by 0x331157: handle_internal_command (perf.c:365=
)
    =3D=3D57268=3D=3D    by 0x331157: run_argv (perf.c:409)
    =3D=3D57268=3D=3D    by 0x331157: main (perf.c:539)
    =3D=3D57268=3D=3D  Address 0x7470 is not stack'd, malloc'd or (recent=
ly) free'd
```

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/builtin-buildid-list.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-build=
id-list.c
index 87f5b1a4a7fa..833405c27dae 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -80,6 +80,9 @@ static int perf_session__list_build_ids(bool force, boo=
l with_hits)
 	if (!perf_header__has_feat(&session->header, HEADER_BUILD_ID))
 		with_hits =3D true;
=20
+	if (zstd_init(&(session->zstd_data), 0) < 0)
+		pr_warning("Decompression initialization failed. Reported data may be =
incomplete.\n");
+
 	/*
 	 * in pipe-mode, the only way to get the buildids is to parse
 	 * the record stream. Buildids are stored as RECORD_HEADER_BUILD_ID
--=20
2.31.1
