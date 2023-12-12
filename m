Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvGM10LJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949A412C
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 08:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702400364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eE+oNE8UoI3+07SvI+nCZI7TzsSGe12jP7mezTHnz70=;
	b=TvGM10LJY054TttU4ClMF0cN/uOSVaMHlk9+nDVh5V2eyJHoxkMW/LIvUosbLgNIxJW8MW
	Zg/T0qC5hJXPDZOo9lVqH1+dUrcW0XSEhULZcGD2W7egO9oyvsKIeiAWXnHIiWfZQ5t5SU
	1bFqD6x5wuVveUoxmd8Hv6Wmda2atDA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-oSVoFNJFMEq4I2CuVnUyvQ-1; Tue, 12 Dec 2023 11:59:22 -0500
X-MC-Unique: oSVoFNJFMEq4I2CuVnUyvQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0E30863015;
	Tue, 12 Dec 2023 16:59:22 +0000 (UTC)
Received: from dhcp131-130.brq.redhat.com (dhcp131-130.brq.redhat.com [10.34.131.130])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C6BFB1C060AF;
	Tue, 12 Dec 2023 16:59:21 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	vmolnaro@redhat.com
Cc: mpetlan@redhat.com
Subject: [PATCH 1/2] perf archive: Add new option '--all'
Date: Tue, 12 Dec 2023 17:59:08 +0100
Message-ID: <20231212165909.14459-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

From: Veronika Molnarova <vmolnaro@redhat.com>

Perf archive has limited functionality and people from Red Hat Global
Support Services sent a request for a new feature that would pack
perf.data file together with an archive with debug symbols created by
the command 'perf archive' as customers were being confused and often
would forget to send perf.data file with the debug symbols.

Perf archive now accepts an option '--all' that generates archive
'perf.all-hostname-date-time.tar.bz2' that holds file 'perf.data' and
a sub-tar 'perf.symbols.tar.bz2' with debug symbols. The functionality of
the command 'perf archive' was not changed.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/perf-archive.sh | 40 ++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)
 mode change 100644 => 100755 tools/perf/perf-archive.sh

diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
old mode 100644
new mode 100755
index 133f0eddbcc4..a92042eae95a
--- a/tools/perf/perf-archive.sh
+++ b/tools/perf/perf-archive.sh
@@ -4,9 +4,19 @@
 # Arnaldo Carvalho de Melo <acme@redhat.com>
 
 PERF_DATA=perf.data
-if [ $# -ne 0 ] ; then
-	PERF_DATA=$1
-fi
+PERF_SYMBOLS=perf.symbols
+PERF_ALL=perf.all
+ALL=0
+
+while [ $# -gt 0 ] ; do
+	if [ $1 == "--all" ]; then
+		ALL=1
+		shift
+	else
+		PERF_DATA=$1
+		shift
+	fi
+done
 
 #
 # PERF_BUILDID_DIR environment variable set by perf
@@ -39,9 +49,23 @@ while read build_id ; do
 	echo ${filename#$PERF_BUILDID_LINKDIR} >> $MANIFEST
 done
 
-tar cjf $PERF_DATA.tar.bz2 -C $PERF_BUILDID_DIR -T $MANIFEST
-rm $MANIFEST $BUILDIDS || true
-echo -e "Now please run:\n"
-echo -e "$ tar xvf $PERF_DATA.tar.bz2 -C ~/.debug\n"
-echo "wherever you need to run 'perf report' on."
+if [ $ALL -eq 1 ]; then						# pack perf.data file together with tar containing debug symbols
+	HOSTNAME=$(hostname)
+	DATE=$(date '+%Y%m%d-%H%M%S')
+	tar cjf $PERF_SYMBOLS.tar.bz2 -C $PERF_BUILDID_DIR -T $MANIFEST
+	tar cjf	$PERF_ALL-$HOSTNAME-$DATE.tar.bz2 $PERF_DATA $PERF_SYMBOLS.tar.bz2
+	rm $PERF_SYMBOLS.tar.bz2 $MANIFEST $BUILDIDS || true
+
+	echo -e "Now please run:\n"
+	echo -e "$ tar xvf $PERF_ALL-$HOSTNAME-$DATE.tar.bz2 && tar xvf $PERF_SYMBOLS.tar.bz2 -C ~/.debug\n"
+	echo "wherever you need to run 'perf report' on."
+else										# pack only the debug symbols
+	tar cjf $PERF_DATA.tar.bz2 -C $PERF_BUILDID_DIR -T $MANIFEST
+	rm $MANIFEST $BUILDIDS || true
+
+	echo -e "Now please run:\n"
+	echo -e "$ tar xvf $PERF_DATA.tar.bz2 -C ~/.debug\n"
+	echo "wherever you need to run 'perf report' on."
+fi
+
 exit 0
-- 
2.43.0

