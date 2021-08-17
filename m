Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7945DC4320A
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 11:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B35E60FA0
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 11:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbhHQL7M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 07:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbhHQL7J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 07:59:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8864C0613C1;
        Tue, 17 Aug 2021 04:58:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so1718452wme.1;
        Tue, 17 Aug 2021 04:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NMClj8Ypq+ih4H38J99oyoEKMrmlbDDN3Ps+QAMa1xs=;
        b=bIBakpYrI9wwQ1Xh4C+E1Z2fLukRCYhJMuKjnhmNzGyWVpuoYIo/Byg989ZIXsHd+u
         69obgaoYAcJPB9MnAuPcFZRSSsNxoHcqNqa5KemgcVRis90tFLdqKvfsWMKqYULLTcJe
         2ydnWOtyTwzEM84MaGHXl40noHnvGsX1Xv9tDhq/HzzyHSmxf80xJru6pre2qJUVKGUq
         SBxrxkGvoVCaO0qTLE+wPMG23iuvz5SF/Vb6QfOOz0XrvDVkx6hnab4dTvuZoqa5i5lJ
         DXLzxDnqAKQjAFsW/X6JR9xebIippblqsi6s7HdWm/y0bWNMTWZmhZagtF3NjCrA+QQu
         Wu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NMClj8Ypq+ih4H38J99oyoEKMrmlbDDN3Ps+QAMa1xs=;
        b=AzhHi+NL9Q5kjskxmj8wM0M2Qr4AM95JCuvRed0t46IJm4PI+d9R+2EBg/I9EDcnTA
         N1wwlkgvhUjWcxT18/xKI3DqUvWMp4VfyJ55GQ8y0LvDk6bu5hlkCo+8P+xVBa3g8cfo
         AagvuXYZHkeqTmZV0rfasgem95kTBIKkO6uEFMcQ0VbmpaHrcdtNggfH4RvaHyQ5cW2Z
         vukjTyp0SQtc1hA9Mp3UfnOg2bzgp9fkDqAaOkJvpMoqcGfMgYcodcmSQgtrj12eE/Rr
         WhpAdu564oHIA958Ukcd/AVtOzHzjfc53NqwKl1l1J1mXw8WZLHV+EN8/ZKxLcUMVHMk
         SI6g==
X-Gm-Message-State: AOAM533UkQvqTQnrX+dxFK5E/Mr8llwIT/XzQl2aFqV4an+90LI9eLpB
        71xfRSpd8bXq1fEp2LWA8Q==
X-Google-Smtp-Source: ABdhPJx+pgqxk/ydLNFWco1xyvjugqvDdGvhC4GowXrMj4t92Lng9dX2AFx3EeIxAmYh8zbKo6+g5A==
X-Received: by 2002:a05:600c:b51:: with SMTP id k17mr2917586wmr.149.1629201515461;
        Tue, 17 Aug 2021 04:58:35 -0700 (PDT)
Received: from localhost.localdomain ([46.53.250.98])
        by smtp.gmail.com with ESMTPSA id b15sm2153773wrq.5.2021.08.17.04.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 04:58:35 -0700 (PDT)
Date:   Tue, 17 Aug 2021 14:58:33 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH] perf, android: fixup get_current_dir_name() compilation
Message-ID: <YRukaQbrgDWhiwGr@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

strdup() prototype doesn't live in stdlib.h .

Add limits.h for PATH_MAX definition as well.

Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
---

 tools/perf/util/get_current_dir_name.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/perf/util/get_current_dir_name.c
+++ b/tools/perf/util/get_current_dir_name.c
@@ -3,8 +3,9 @@
 //
 #ifndef HAVE_GET_CURRENT_DIR_NAME
 #include "get_current_dir_name.h"
+#include <limits.h>
+#include <string.h>
 #include <unistd.h>
-#include <stdlib.h>
 
 /* Android's 'bionic' library, for one, doesn't have this */
 
