Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2703B7B7D
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136225; cv=none; b=i6OsvVd314VdeohnbFfsZ7Z77hVa3jWCOIN/jST+L1cSzziq4SpAF7koYU4vGxAkJXeybi3/pGy/e0Cj7g+vQjLVRDsnGLp9P82KBAlo9GgojY8EcJy0Fe4spPuF5DRb7gVBQYI9urbQK+m2+M51IIPhTq7nh5xy61JaWh/PICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136225; c=relaxed/simple;
	bh=3dhYgo+pNP9zjDryLIiYmj/Whq0nFhpgX3flylvnnsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDPRbloFunJsUTshH1KaPO+4hE7mgMszhLQPzEY/qi5neo8ud3apQRiF7zlmEfuBQIld422WcCqG48x3fLE1zRqOpeFQwoGAP5Fw1iuc15nrwMbCJTujU2iSbLkA6f78QTcT78yfDeBu+wi0C9WWElDoLGIWC5qDvX/vo9M3rmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScC/N6aa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScC/N6aa"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-845397d1221so2471155b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782136223; x=1782741023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKgW4+pNodbEv/Swhh7lEYX3onGIwRL3Ox7oRUBNEns=;
        b=ScC/N6aarGPaDJcZNE+116ksgc4Ri2Wempbq4ucuDd0Zis/6vfLmA5+6vCjmRyxKiI
         6Cy3iOAeo1ioXn/+tLeDkiEXeT6nLgpIh1zEQSxYPxSqu3kHDNJSS+82elcZOZfoDcpL
         3nUSTFvxyYNNZc9hGsqfjLIy1Mc+hIcN457gmXzZWdgRrb6zqhngplXikKxLVTnYdLCG
         L6I1I3AnLA5v0U9Q5uKTS6yJFU+D29iF0jpLY22N8xlI07dLsEh3OldrHfw4K1dhSF3E
         UVsiAQcaop5+P0CgiszY8r881/+wOuyY10xYoNjsnFBWzsWqGMjOnTMUHLfG/tH/Fngh
         3oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136223; x=1782741023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKgW4+pNodbEv/Swhh7lEYX3onGIwRL3Ox7oRUBNEns=;
        b=KXV9+cIVnAuzc43FQpyFxPrzsFHOKGvl33odZp9gv4uJ8q8CmDz4HiwRoN8+/HFwlh
         zDNvTGsfO6nLuNq7i9dlZThRkNopciF+YAkvO21En5OZaePDiUFd33xHW9+bcsY50vaP
         42U9fGs+ebSFEJNTaOSqHqmr/qoju1r+BOOcGv9p/PyrrL8WFTJoq/kCWrI106n/sPqG
         YEGKHdBvxKMvmb1gkukvFsLahMQJabtRWx/UIPQaZn1mxaTDGmTOTbapLfGQUpOd/tln
         T2Jxfym+Ltbde5tX7yQImJqhinopOULYgQ/O8nZ8EPIm3FRCrXHgtZeLKzC6Jn2+PdnH
         37YQ==
X-Gm-Message-State: AOJu0YxbJyNVRFwCmBblHcW40dMY73OOmViYoOaYGl4YQHJs4qBxMx5Z
	nOfCikO0veizthhKwB3l8xdgivg/45BDZ3MYkCBZKEihxmxCwohPaZ0c
X-Gm-Gg: AfdE7clGW9NAsaqEqb6XodRVEA2sf2SHtLrK/Id8lrwxWvNSz3RY8hcqE88IwwTsdH8
	RV+SON/UVSoVLCXQuUFVefauB6i3woK54ebdbeAa/3smm9NGrsJg4Tv9g/5Ry/a3150He7aKLRg
	e/5nQErhe8UsvoHZJz1oJ8yBcxDDMoaiFWf21eE4XebVd2tubgaguCgerflc6V92NxAt7Z3aFVm
	k0qipJgVkDUvfxHH4PKQxZ+30rdcX5MMuy2olu1zi6N5b2/fl/8RidDRCcyOk4sSS98Y1G0I6No
	GFJiEd+Gu0MRRxzQra7nFVHCdO6XnomVOQHvEGngqVEoakOxZnPUJthNPuuqJOurLO5uhISOUU3
	sCP3j5ISgMKaXvsywqgT4xCtkJlCTve1d262Gr3uS1SDajMUjYf1GYVzGEKOZSX8GI8e9OhCSt5
	WzMjmy8am7khvSKlBSVwCXpnVNKg==
X-Received: by 2002:a05:6a00:14d3:b0:845:4d3d:c8c with SMTP id d2e1a72fcca58-845508c0737mr15848543b3a.39.1782136223267;
        Mon, 22 Jun 2026 06:50:23 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:47f:2522:acac:f810])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ea146asm7606177b3a.43.2026.06.22.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:50:22 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	ravis.opensrc@gmail.com,
	akinobu.mita@gmail.com
Subject: [RFC PATCH 1/2] perf python: Add access to various members of evsel
Date: Mon, 22 Jun 2026 22:49:32 +0900
Message-ID: <20260622134933.35773-2-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622134933.35773-1-akinobu.mita@gmail.com>
References: <20260622134933.35773-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change is necessary to specify the same PMU event selection as the
'perf record' -e option from DAMON's userspace tools.

For example, a Python script like the following will allow you to obtain
the values to be set in the type, config, config1, and config2 members of
perf_event_attr by providing a symbolic event name.

import perf

if __name__ == '__main__':
    evlist = perf.parse_events("cpu/mem-loads,ldlat=30/P")
    for evsel in evlist:
        print(f"{evsel}: type={evsel.type} config={evsel.config}",
              f"config1={evsel.config1} config2={evsel.config2}")

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 tools/perf/util/python.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cc1019d29a5d..3f108b405ee3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1241,11 +1241,60 @@ static PyMemberDef pyrf_evsel__members[] = {
 	evsel_attr_member_def(sample_type, T_ULONGLONG, "attribute sample_type."),
 	evsel_attr_member_def(read_format, T_ULONGLONG, "attribute read_format."),
 	evsel_attr_member_def(wakeup_events, T_UINT, "attribute wakeup_events."),
+	evsel_attr_member_def(config1, T_ULONGLONG, "attribute config1."),
+	evsel_attr_member_def(config2, T_ULONGLONG, "attribute config2."),
 	{ .name = NULL, },
 };
 
 static const char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
 
+static PyObject *pyrf_evsel__get_freq(struct pyrf_evsel *pevsel, void *closure)
+{
+	return PyLong_FromLong(pevsel->evsel.core.attr.freq);
+}
+
+static PyObject *pyrf_evsel__get_exclude_kernel(struct pyrf_evsel *pevsel,
+						void *closure)
+{
+	return PyLong_FromLong(pevsel->evsel.core.attr.exclude_kernel);
+}
+
+static PyObject *pyrf_evsel__get_exclude_hv(struct pyrf_evsel *pevsel,
+					    void *closure)
+{
+	return PyLong_FromLong(pevsel->evsel.core.attr.exclude_hv);
+}
+
+static PyObject *pyrf_evsel__get_precise_ip(struct pyrf_evsel *pevsel,
+					    void *closure)
+{
+	return PyLong_FromLong(pevsel->evsel.core.attr.precise_ip);
+}
+
+static PyGetSetDef pyrf_evsel__getset[] = {
+	{
+		.name	= "freq",
+		.get	= (getter)pyrf_evsel__get_freq,
+		.doc	= PyDoc_STR("freq"),
+	},
+	{
+		.name	= "exclude_kernel",
+		.get	= (getter)pyrf_evsel__get_exclude_kernel,
+		.doc	= PyDoc_STR("exclude_kernel"),
+	},
+	{
+		.name	= "exclude_hv",
+		.get	= (getter)pyrf_evsel__get_exclude_hv,
+		.doc	= PyDoc_STR("exclude_hv"),
+	},
+	{
+		.name	= "precise_ip",
+		.get	= (getter)pyrf_evsel__get_precise_ip,
+		.doc	= PyDoc_STR("precise_ip"),
+	},
+	{ .name = NULL, },
+};
+
 static PyTypeObject pyrf_evsel__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
 	.tp_name	= "perf.evsel",
@@ -1255,6 +1304,7 @@ static PyTypeObject pyrf_evsel__type = {
 	.tp_doc		= pyrf_evsel__doc,
 	.tp_members	= pyrf_evsel__members,
 	.tp_methods	= pyrf_evsel__methods,
+	.tp_getset	= pyrf_evsel__getset,
 	.tp_init	= (initproc)pyrf_evsel__init,
 	.tp_str         = pyrf_evsel__str,
 	.tp_repr        = pyrf_evsel__str,
-- 
2.43.0

