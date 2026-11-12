Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794503186;
	b=Wd4yhjS2OPnxyeSRyJir//jr7aXcEMQn6Peh+pEDhkeCiruj5bwKfKHS6R9JnsUuMWcJ
	 WHmnUx098/XY2bRDkoAYOIrJcO0Gj+OEWmjCaS+zQJj9hEu6Zv4rAu6kbcVBXcVg62meO
	 bwD2AHfvyj5Tv64oZcBw86FJhvWrbW1mwpqdKmNZnuWSczyrESqRe8uNHvhZthPllu7lR
	 YQuS8v/Ye0ceRhhwCpkxvT86USKo2ZVmvNHXeW/+yfSDoLuGvFvJr/RJ8eaD35HfdXq10
	 gdkvMI+J13EPoj7xc6k2KDKzZbcq/3eMV+x2s9mgJ/tR8/Z/JBoMLRHsbnHZ39MwFaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=n1UFYaTUgMxyzKDugLadjgfN92wam7xCBrE6jHJt4/U=;
	b=huah9ggWt3CCCyqAHsEELVw+7uig4HV1ImVJexoD/Kb+ep5Ny6hSFu/ZarvB7IzBVtip
	 pnt0383jgMwrnm23KQk/KkfWk9PONzEx/PwE6ZFVsHaD5c4hX6JIFacSGUxHtHUDwo8yf
	 HYcmIrzTodsmHAkX8LER/DexMFn1HZiEpKkofiGzPwLdnssX4/6kGj7nKA/muK6dT+sIJ
	 fguc7xX00WQmv0WrUxEqjJPNkN/GqJ+YBknhhKgZ9L9r7EVg8wpTKa17/IKJJjX/qBYlY
	 AgLM7c27NVaS5e9VFEqY4kcmHicaOYfux4qea3DstTW09sLmTNtYXTEdSdAJtUPcIuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G4t4Zafi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD545606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 17:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD545606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G4t4Zafi
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso1143a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 09:06:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794503185; cv=none;
        d=google.com; s=arc-20260327;
        b=so9rIlo74GJGvSl8WjlSYhK/RrvWoKwGrBTnMYgmHSV7cB7nSH7ChKOEPDzQmuEVtY
         +vBUfeQQhTVCCxFYJEU4IdXIZnD5g5s+GL3vKjiZ08zGzLbtUzmQYlXza54u/KsgZBT7
         H9Vr6opP1UVpd8cDTv8wPCMIUY1d2PwIjynnbVW39vAOf1jD78elMtD97KLBQBSSYMUS
         by7u8DFotMEsSjqX1wMlCyx4xSOK6zTgdamgA9NiThzHmjQjxjER/92xahhzWo5RlgAR
         TTuN3BhbevFiXkw27+UDhJmhqtwCb1qhUKcZWN8D4SoqzjpU1UBXdlR4ohcpzDxhP+P8
         ibXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=n1UFYaTUgMxyzKDugLadjgfN92wam7xCBrE6jHJt4/U=;
        fh=xHFFZbuWdl3jeIob27LeqLqr11I92nbKOWNz36c6g4Q=;
        b=sqpIgsA8F4RLi19sXSnl//O7XXVoJHRe8VYm9mHMf2IPZi3/lxyaKTX4x/sVxcYAR4
         mEMv84s+nFG8PGUkl3eW7Qlqf6vpfA9JU3AHvn6NNpNNzaZ3VxvH6ACNVyX9bVQJ127s
         u4NsGo63fJx4+fEM6A0fWHzndufLTDsk7yPGpT8ZGO1rHw92eQe1QwuVRHSJmIKCMmJF
         p4LCRCaOEUOLwwxvhSv6zDpWQJxqtr/w/yNONszlgjc5xoSxP1/nxCqkafqV+AUCWanD
         aRl1M0TGX/jubBdo6Jd+gNyyh24ymu042zGASy0t2h4w4uUlNa/n8T15YImFYHItVhuJ
         ZloQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794503185; x=1795107985; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n1UFYaTUgMxyzKDugLadjgfN92wam7xCBrE6jHJt4/U=;
        b=G4t4ZafiTziELVVr1FXyuIirw8jqTgQNi92J9ZUtw96wy4nmfD5jWCUsHYuMnbMeTk
         UyLEjywopFcNQfLI1wjAt4cAFrOIMxOfKLvX9/XKkt1GD1MFOQ/re2cyxNTfe83speWy
         eSw/27Eizb+HWulX9d0+9JZ7E+mUb5jwSuVfhjyXPi7Fr+TowFuna82zGdZsG0c6485i
         G9NStxBt5bG0erCWLfmtCxlCSWjayOGuYkIDS3m7ApNVU5l3vu248UZQy14jL88mHUdq
         408x0hPXWvonAZS3KS0jCl0GrgvQvIRxCf0M4aVaxHmFV88mtS+xzh7qKnm15cbWOMQ4
         dXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503185; x=1795107985;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n1UFYaTUgMxyzKDugLadjgfN92wam7xCBrE6jHJt4/U=;
        b=sSAsV2e9JOsSjMUPyhji28YBYpB3fYKdL3WnN0vjf6k5duV6voBpT6ptf8zpPXYgvn
         L/Q1uSpCekkQqZLYpZwsQpTvHnKuoJgeki/jZfkpRWQUI1xT01sI34IwxUVxqUbg0RU3
         4DEY45l8j/God3pBAw3JSJrAu/Y5HT2S1V4A+AWNywmvazhZwJfu09adpVTOonw3TTXl
         ih3sR3/XZQwLhGNcHBA+9SHY5eQaZJ+4D/iXdaqIAkrh5CL6GuMdfYHXOAVx/7h6OIsx
         O+eqlks+Eb5jQt+JCI4mE6s+TIbNqTkDeDoRhJz1MmV5e6/lktkpO2bE1m/qWMz13+Rl
         YVxQ==
X-Forwarded-Encrypted: i=1; AL+hErG8Xpj7W2uhLST69+rmvADC0enUFrjF1jNpP2egW9xVuv5xsJtUAIp1WMu2dBIAiG8KuYbbu19vidJz6r6TOxss@vger.kernel.org
X-Gm-Message-State: APuU4Z+JRB0SSvLcv4T+J9uiBHIaQxZkXC1HOPqe3d1ozIJud71a3ngn
	k4Wx/f+sTALEbgAROHnTZu1hglOJRH1AwoQ2jkhuYeCtYKv3uh6EPKPKd9ll7zbOxmBM/gy5Zg+
	o4MxqR1Scj0bFwFdNA9r+dUmw0REFYWdCFA==
X-Gm-Gg: AYBFou0Gi2a/9iMAZVeebVjKHpeB4u4lV3rqX5A3nFltOPe49S4vXqSujeiG4CFHWPH
	gRSuUbZbhcgUu54Xn/TL9ysqhexlzWgViH6oO3GmGK9AhdxjI+AV1k+TCifLybtogyxobGhSR8B
	FY1hVuD2rKsZk6Vu9RYuyCf3va54b64dlFW00NWf32Bfjg6TnPTzh3LK3batrUlD2fpf5BDI8mW
	SVN6GXgNwY7vcImcfMtlOgMEJilU4/9EqNEsmy09kyoe3mtPN1t628dqF95AAD54iqQa8ZrFLBb
	5ckf69przgeGhIqLWXs4CgYt7OyURjL/1eQ5WQdjY8IRBrWB2oKgfPZ3Yvk9CLLfiBVJyahaau5
	PLYhGhojDQQpEZ0ovlG+oLifcocGfihKfzx/1bOIlqwWiAfTQWFjPUyLC5+N60+nQV6qIx78jL1
	UzlhFJX5jsufskM8AZoA==
X-Received: by 2002:a17:90b:5347:b0:3ac:b6eb:e0dd with SMTP id
 98e67ed59e1d1-3b182f9bcdbmr6127741a91.50.1794503184714; Thu, 12 Nov 2026
 09:06:24 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 12 Nov 2026 09:06:23 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Wojciech Szpucha <szpuszi@gmail.com>
Date: Thu, 12 Nov 2026 09:06:23 -0800
X-Gm-Features: AclHuK_-710F4Tm24mSZpzGA3sLAhRVHhRU-7oKpgPopwSYPEC_JfCwLpT3pf_Q
Message-ID: <CAAcuPuJUt=Qf6uuTVv63jiY_iCjsvjso1T=WYSFQB=i6Wzb2Vw@mail.gmail.com>
Subject: [PATCH] tools api io: Return high-bit bytes as unsigned characters
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Wojciech Szpucha <szpuszi@gmail.com>

On signed-char builds, io__get_char() returns negative values for bytes
0x80-0xff. This makes filename__read_str() silently truncate non-ASCII
input in standalone libapi builds.

Cast the byte to unsigned char before returning it as int. Add regression
tests compiled with -fsigned-char, since perf defaults to -funsigned-char
and already avoids the issue.

Fixes: e95770af4c4a ("tools api: Add a lightweight buffered reading api")
Signed-off-by: Wojciech Szpucha <szpuszi@gmail.com>
---
Tested on Ubuntu 24.04 x86_64, GCC 13.3.0: standalone libapi reads 0/4
bytes before the fix and 4/4 afterwards. The API IO regression fails
before and passes after. libapi and perf build successfully; checkpatch
passes. Full perf suite and kernel builds were not run.

https://github.com/szpuszi/linux-perf-io-test/actions/runs/43257707229

 tools/lib/api/io.h        |  2 +-
 tools/perf/tests/Build    |  1 +
 tools/perf/tests/api-io.c | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index 1731996b..25e2008d 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -91,7 +91,7 @@ static inline int io__get_char(struct io *io)
 		if (ret)
 			return ret;
 	}
-	return *io->data++;
+	return (unsigned char)*io->data++;
 }

 /* Read a hexadecimal value with no 0x prefix into the out argument hex. If the
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 58858f3d..c3ba1fca 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -79,6 +79,7 @@ perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 endif

 CFLAGS_dwarf-unwind.o += -fno-optimize-sibling-calls
+CFLAGS_api-io.o += -fsigned-char

 perf-test-y += workloads/

diff --git a/tools/perf/tests/api-io.c b/tools/perf/tests/api-io.c
index 0ba3d5cc..f283712e 100644
--- a/tools/perf/tests/api-io.c
+++ b/tools/perf/tests/api-io.c
@@ -98,7 +98,7 @@ static int do_test_get_char(const char *test_string,
size_t buf_size)
 	for (i = 0; i < strlen(test_string); i++) {
 		ch = io__get_char(&io);

-		EXPECT_EQUAL(ch, test_string[i]);
+		EXPECT_EQUAL(ch, (unsigned char)test_string[i]);
 		EXPECT_EQUAL(io.eof, false);
 	}
 	ch = io__get_char(&io);
@@ -118,6 +118,7 @@ static int test_get_char(void)
 		"12345678abcdef90",
 		"a\nb\nc\nd\n",
 		"\a\b\t\v\f\r",
+		"\x7f\x80\xfe\xff",
 	};
 	for (i = 0; i <= 10; i++) {
 		for (j = 0; j < ARRAY_SIZE(test_strings); j++) {
@@ -290,6 +291,34 @@ static int test_get_dec(void)
 	return ret;
 }

+static int test_get_line_non_ascii(void)
+{
+	static const char test_string[] = "a\xc3\xa9\xff\nnext\n";
+	char path[PATH_MAX];
+	struct io io;
+	char *line = NULL;
+	size_t line_len = 0;
+	int len, ret = 0;
+
+	if (setup_test(path, test_string, 2, &io))
+		return -1;
+
+	len = io__getline(&io, &line, &line_len);
+	EXPECT_EQUAL(len, 5);
+	EXPECT_EQUAL((int)line_len, 5);
+	EXPECT_EQUAL((int)strlen(line), 5);
+	if (line_len == 5)
+		EXPECT_EQUAL(memcmp(line, test_string, 5), 0);
+	len = io__getline(&io, &line, &line_len);
+	EXPECT_EQUAL(len, 5);
+	EXPECT_EQUAL((int)line_len, 5);
+	EXPECT_EQUAL(strcmp(line, "next\n"), 0);
+
+	free(line);
+	cleanup_test(path, &io);
+	return ret;
+}
+
 static int test_get_line(void)
 {
 	char path[PATH_MAX];
@@ -337,6 +366,8 @@ static int test__api_io(struct test_suite *test
__maybe_unused,
 		ret = TEST_FAIL;
 	if (test_get_line())
 		ret = TEST_FAIL;
+	if (test_get_line_non_ascii())
+		ret = TEST_FAIL;
 	return ret;
 }


base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
