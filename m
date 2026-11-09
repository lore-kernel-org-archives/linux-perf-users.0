Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235339;
	b=3ra7p5uY05aZKVMmhYKoTnIp3kH7IU5tJVx27i9aFf7Q3r2R2uYKXo1Wvk0ckSDh70Mf
	 0B8wUsN2FrNbDQB9zsx1ezi/WfC69a156y5J15fVAjOlzPpD+TR0udQbZIcwbHUGbCMwC
	 Qkc1i8olYl0hSPXFSldmk8e3AAaRBFDTBFVnMiuOiGerErRQfb7O9gubFZYyVmn2vmkpk
	 23oAJhiwRcErhrZhgOQBIDzG/2MhNjI7FhkCgryOl22sLTq4yij5l9OJKsQX0FFlXKYRn
	 AmBf4wl+GIX24fuP/EfDV3BiZG8SmK0uLkgeUkm4OMTKfmW+5iF98jN1QZE1GueubFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4uSQy2+UK8rG2FUK7vsd1guiTwpW8ISh3RHk4l57drk=;
	b=FOEv8yP03nhiY2hAFZvVC7zMdbTww1smwBVNtpZlY1uHcs7znuHcmEnZ9TEBP9XpE/yi
	 YchePMjVp3qtj6p9BZ5dhzsdMnj4ZK9qDkSVVUnxEmmnxhULrXQfbjRHViQLGQ7kxxFTe
	 /CYHCLKEgRNlyQs+eII1RAMZLrxNrO7gAypCh7n6Z3xbxe7cImMc6yBsTG6nnfA47VEXG
	 IpuuIEeEf3BJ6wM8n9XREydPbbrh2ppznPK6sf9BYUoDg/5kFedpJDT65BXBZawNdTSZW
	 jJ+5XBWg52oyFOW9r0WlJ95RqYbeNELOGvlf7oqtXc5It22wyykuDn2f1OsoYOGgd6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mU7xb51q;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1C606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 14:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D1C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mU7xb51q
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so10148175e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 06:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794235337; x=1794840137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4uSQy2+UK8rG2FUK7vsd1guiTwpW8ISh3RHk4l57drk=;
        b=mU7xb51qWjBDCLclutZrPHTAT6vfhjEhNUgePjwc35o4LgUyNGjS8mHdf07e6zbz2F
         wrGNIwafWd7sHoexj0XvgCOc9HUCrGOSHfaQT4zx5gYMY3XfhtFW4auSFPezJtU4yyC6
         F4ohkEg6Cd2AzQeVpLIcHRut6dwQacrJWGJkl4KQcZnn596TB2nqI4EMKrKAln8+HyRg
         mXh0HtP6YGrngEe0kkSA0HqiZ+VnuYw0yDICZnXc/uykPOa2CwCt2BXRuB67pycqv3oV
         gGvLxoeUv4dQlRpsyXNU6Xm+8I1GY7MOSvw59L939Ev3kRjEb8HTKlpK4WmpRVyYihrm
         fu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794235337; x=1794840137;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4uSQy2+UK8rG2FUK7vsd1guiTwpW8ISh3RHk4l57drk=;
        b=wAogwkCo4ocNcObRRai+DyPuQejBioX4kSHzvvdAHMuiUF8gH1MY5dC94l/nc8qqL/
         aWxcneYFacbbOeqWWCYN665ZMP/sh89LGgF54mMY5pBW+LOJhpeYZpHapQg0GdNoxElH
         UkGX+VlxrktbsokuETgckQ0nsqKvNm/DI5PFkUbace2dYordEpfdUSWgBqIgDhWMMPFR
         yJQ4Pv/Swa7f/7a5WcUJJsF4MpVcq/63oPkTVv4uhBQ1B5TfJXdTNtS0vuhIRuJT9GYt
         pglBIqO68/q8pG45Hn9TxBRttTArAYrw/YtOzGgSjM1z0w8YajzTDK7iSwrTVov3pXVQ
         jJ9A==
X-Forwarded-Encrypted: i=1; AL+hErFu+XAd9wp0nDSE4h6RS+SytXKdnX0ThvAP+ciXv63YrRrajVbW6G3X41HNAHVrxlHq4N2fjqAjU3aADwNlx5u1@vger.kernel.org
X-Gm-Message-State: APuU4Z/NrIp/gdahvZ5lSbmvgpwl2jZCAn8Tt+uCQANiGDoZerG9bVha
	/VxYsMJZpoilKbLpUqxGvFJ9Jp/kqsni6Jwo6Qy43K5anc0rNmUr4nM+
X-Gm-Gg: AYBFou1kzNhdbw/m2yHp80ZujdyRH20CR2djQh4mbzGYuI2tPSKIWrfY9/ZCx0jT134
	KGaobM948GRx6oh1AkvLypXrdEIgozHCjGz0NCQDS/kmaOvIr5sp0Bq0RxeFE73PoanmZHydp7J
	upJ16tXF1qNG4yNkf1QccjSp0Q7ri+oC/OTsnNqs1u9lAgCA5d1N1fIIn+Ho6dJ0AYbOh8va9ej
	VAJaENG5/7faH0PBEvUmkkJjS+j5pVb0DRkpI/448nPpk87xr4PomAYqFbP46LBmJGe82t9EF3g
	7/vS3v2eA/4VV5IYg4VFY2T9DmA0kW4LUTw3pQeaEDv/RlObmtzXfu/Xc/Rqt9PSLHct4rKvBR6
	rODBVITc/9xJP7MZ8y+FdyZiqre+d8t/2GHbrs/jZnyPHpKYhl3c8tFSu5XquWXPVw/f6iwX4JV
	9AbKEssRQ1lwYgW6PRAoQlxiUmW4JMUvaxFUAb9PstuCxPYAvv0Lh2Cwrbv0GCer9inOV1/ftSL
	OUicunATzuhVDNnhfW8/RENCYtA7LJ/ZcEVNDOCPt49WMziX8u527lBLbPQ9yP2uAkGZ4r+Nzmk
	eVCfNv+k95Rp+oSTzH0dL8N1YP57WzzJYZidv8wQ+Kc=
X-Received: by 2002:a05:600c:3b8f:b0:4a6:42cc:bf65 with SMTP id 5b1f17b1804b1-4b963c6674fmr87866635e9.17.1794235336889;
        Mon, 09 Nov 2026 06:42:16 -0800 (PST)
Received: from ADRIAN-PC.lan ([171.22.87.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-497be726d9fsm1759034f8f.49.2026.11.09.06.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:42:16 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH] perf config: Use va_copy() in perf_config_scan_cb() to avoid va_list reuse
Date: Mon,  9 Nov 2026 15:42:09 +0100
Message-Id: <20261109144210.1626450-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

perf_config() iterates through both the system-wide config file
(/etc/perfconfig) and the user config file (~/.perfconfig) so that user
settings override system defaults.

If a configuration key queried via perf_config_scan() appears more than
once (for example, in both /etc/perfconfig and ~/.perfconfig, or
duplicated within the same file), perf_config_scan_cb() invokes
vsscanf(value, d->fmt, d->args) multiple times on the same va_list
without reinitializing it.

Because vsscanf() consumes arguments from 'd->args' via va_arg(), a
subsequent match reads past the end of the argument list into
uninitialized stack memory.

Copy 'd->args' with va_copy() before calling vsscanf() in
perf_config_scan_cb() so that multiple matches safely overwrite the
destination variables with the latest value.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 tools/perf/util/config.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 287401f159e66..f567cc338ca9d 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -1091,8 +1091,13 @@ static int perf_config_scan_cb(const char *var, const char *value, void *data)
 {
 	struct perf_config_scan_data *d = data;
 
-	if (!strcmp(var, d->name))
-		d->ret = vsscanf(value, d->fmt, d->args);
+	if (!strcmp(var, d->name)) {
+		va_list args;
+
+		va_copy(args, d->args);
+		d->ret = vsscanf(value, d->fmt, args);
+		va_end(args);
+	}
 
 	return 0;
 }
-- 
2.39.5

