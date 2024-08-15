Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF822331;
	Thu, 15 Aug 2024 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685811; cv=none; b=sjZxfS6BWNXU4pcSwB/KyxjBxj0XW5/vIQ+FCP9H4lXMmh4kPUc2cshqw0OI3itKkzzRfRPhZpmRRzYXBrc8KmWVDB8BrvljbLqgpzkxTCTD95dOV+hiJSOEW86/caxweNgb5HbyGOnThLa9sNc/zAkiI64mx0MYuxepDrJpfCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685811; c=relaxed/simple;
	bh=8PSYrEoSqTOKDPb3MKTCzPSrb0bPjJzPpCLLP8YEZVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ta7X5KV3nNMaX30cOcnrCPS1ob9ss9jPCIuFqLEpxqsjYC0nsG8ewZZtiDVuzRO6IgySxh5FPCwJ1BU8uchxKbvHdJknOaUwBYGq6urrMlQeD4d4QTpDdwhHDaZj9F93jAeSs9SpE5DRju+SwMcEdlTvVfsaxDPeGfN7/DyKW18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLYQ4pve; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLYQ4pve"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-26ff51294c4so386518fac.3;
        Wed, 14 Aug 2024 18:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723685809; x=1724290609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSgV602+Ysoo9Kb67N9Db2Q5XyQw6Ub7x1SiEGD+57U=;
        b=bLYQ4pvekIKLMfLRjv4k5J7aOkX9YLPax/uKKbKku1DNxcAVz5ndjeL8HTssTO/3dp
         eRLX/Z8jTxY/mhWTHWBgPvlAqD4JNyTelhQjdyIweA8jDmIRx/6lIvHziY3LPjnEW7r8
         dAo6AZc7yPqybTh7CdIVErvf1pZpqUyRLGMTS7lJzmIlD417NnNbGwcl2Og69uEkXeiY
         2cD/R9eWednd+o1qL0sJ8IpDepsLZOKgBwEzeAvit1piR8laksIbkng50HGcNrlO16EU
         OQk4F9nUGkulEDqWq0O8qVnNPMPyV/384rfepkVj1KAaBCnNM2gO1q14jwq9z+8hJhtI
         x3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723685809; x=1724290609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSgV602+Ysoo9Kb67N9Db2Q5XyQw6Ub7x1SiEGD+57U=;
        b=ugy+75dnR/QTd/jYcfPhr1RFhjhS2F3hieMxbgQLnPjMswY4OSFfksm+Gl4uBSSWY1
         /OpJWnjawV2qjUFzxXqwvVSE1FrNhoQGNKn2l0X5bMv9bh4lFaXaO1bLtkpJSETIiXoO
         NTB2t1kSXHTK9Z0YtJUKirHWKzIgkKuX71CfG+CJSiBHiP8pxyZttbOrSOGx8o37Plrj
         RhEa7Sp3KCBC+XKXHGtXLHDZ04asOXtNEE/n3YtymkJkxYkLF0Gn5M+S2GCnB6kZ+3Go
         VMJDMck7eSZftThNZFMfAucN08P5GRy+wu3SxFkLsaaSRGNrR8TjxMl4MgUti7EI/d9i
         Ghtg==
X-Forwarded-Encrypted: i=1; AJvYcCUxM+WF8O1iQ1YjeBzF+wfEdE3uBzLcREkSscm4onhnv+KuO2bw/nNqLYT96HfzmEaGhDrVQyOBDp5FpL7NGwqL6vT/SBXQVVxXjAwmYqg+2AaGrn0cBZTtzb5JL/ehRn+eQ7HD//tKJ0zbAB4sLw==
X-Gm-Message-State: AOJu0Yziwi1zgOoQigDX7h45DJGH21v+u3kmttKepxJucXOz5sPJajRL
	l1703uhGFi6HigasLS7UuXMKaMCjy1Bs+P9CPcQJRhI2TqHwTZnw
X-Google-Smtp-Source: AGHT+IHEDKX5YUMGycdZtbZwf9LMvNFKsQr+9vx63j501bDOihrYJh6U/YHtgfDh386V6vXcUFkBDQ==
X-Received: by 2002:a05:6871:28c:b0:261:7af:719c with SMTP id 586e51a60fabf-26fe5be0376mr5628203fac.35.1723685808695;
        Wed, 14 Aug 2024 18:36:48 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef412bsm196842b3a.123.2024.08.14.18.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 18:36:48 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] perf trace: Add trace__bpf_sys_enter_beauty_map() to prepare for fetching data in BPF
Date: Thu, 15 Aug 2024 09:36:19 +0800
Message-ID: <20240815013626.935097-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815013626.935097-1-howardchu95@gmail.com>
References: <20240815013626.935097-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set up beauty_map, load it to BPF, in such format: if argument No.3 is a
struct of size 32 bytes (of syscall number 114) beauty_map[114][2] = 32;

if argument No.3 is a string (of syscall number 114) beauty_map[114][2] =
1;

if argument No.3 is a buffer, its size is indicated by argument No.4 (of
syscall number 114) beauty_map[114][2] = -4; /* -1 ~ -6, we'll read this
buffer size in BPF  */

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 106 +++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 97076b962688..e7e8c89d9538 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -113,6 +113,7 @@ struct syscall_arg_fmt {
 	bool	   show_zero;
 #ifdef HAVE_LIBBPF_SUPPORT
 	const struct btf_type *type;
+	int	   type_id; /* used in btf_dump */
 #endif
 };
 
@@ -926,6 +927,23 @@ static void syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, str
 	arg_fmt->type = btf__type_by_id(btf, id);
 }
 
+static int syscall_arg_fmt__cache_btf_struct(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
+{
+       int id;
+
+	if (arg_fmt->type != NULL)
+		return -1;
+
+       id = btf__find_by_name(btf, type);
+       if (id < 0)
+		return -1;
+
+       arg_fmt->type    = btf__type_by_id(btf, id);
+       arg_fmt->type_id = id;
+
+       return 0;
+}
+
 static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_arg *arg, u64 *val)
 {
 	const struct btf_type *bt = arg->fmt->type;
@@ -3520,6 +3538,83 @@ static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
 	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(trace->skel->progs.syscall_unaugmented);
 }
 
+static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int key, unsigned int *beauty_array)
+{
+	struct tep_format_field *field;
+	struct syscall *sc = trace__syscall_info(trace, NULL, key);
+	const struct btf_type *bt;
+	char *struct_offset, *tmp, name[32];
+	bool can_augment = false;
+	int i, cnt;
+
+	if (sc == NULL)
+		return -1;
+
+	trace__load_vmlinux_btf(trace);
+	if (trace->btf == NULL)
+		return -1;
+
+	for (i = 0, field = sc->args; field; ++i, field = field->next) {
+		struct_offset = strstr(field->type, "struct ");
+
+		if (field->flags & TEP_FIELD_IS_POINTER && struct_offset) { /* struct */
+			struct_offset += 7;
+
+			/* for 'struct foo *', we only want 'foo' */
+			for (tmp = struct_offset, cnt = 0; *tmp != ' ' && *tmp != '\0'; ++tmp, ++cnt) {
+			}
+
+			strncpy(name, struct_offset, cnt);
+			name[cnt] = '\0';
+
+			/* cache struct's btf_type and type_id */
+			if (syscall_arg_fmt__cache_btf_struct(&sc->arg_fmt[i], trace->btf, name))
+				continue;
+
+			bt = sc->arg_fmt[i].type;
+			beauty_array[i] = bt->size;
+			can_augment = true;
+		} else if (field->flags & TEP_FIELD_IS_POINTER && /* string */
+		    strcmp(field->type, "const char *") == 0 &&
+		    (strstr(field->name, "name") ||
+		     strstr(field->name, "path") ||
+		     strstr(field->name, "file") ||
+		     strstr(field->name, "root") ||
+		     strstr(field->name, "key") ||
+		     strstr(field->name, "special") ||
+		     strstr(field->name, "type") ||
+		     strstr(field->name, "description"))) {
+			beauty_array[i] = 1;
+			can_augment = true;
+		} else if (field->flags & TEP_FIELD_IS_POINTER && /* buffer */
+			   strstr(field->type, "char *") &&
+			   (strstr(field->name, "buf") ||
+			    strstr(field->name, "val") ||
+			    strstr(field->name, "msg"))) {
+			int j;
+			struct tep_format_field *field_tmp;
+
+			/* find the size of the buffer that appears in pairs with buf */
+			for (j = 0, field_tmp = sc->args; field_tmp; ++j, field_tmp = field_tmp->next) {
+				if (!(field_tmp->flags & TEP_FIELD_IS_POINTER) && /* only integers */
+				    (strstr(field_tmp->name, "count") ||
+				     strstr(field_tmp->name, "siz") ||  /* size, bufsiz */
+				     (strstr(field_tmp->name, "len") && strcmp(field_tmp->name, "filename")))) {
+					 /* filename's got 'len' in it, we don't want that */
+					beauty_array[i] = -(j + 1);
+					can_augment = true;
+					break;
+				}
+			}
+		}
+	}
+
+	if (can_augment)
+		return 0;
+
+	return -1;
+}
+
 static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace, struct syscall *sc)
 {
 	struct tep_format_field *field, *candidate_field;
@@ -3624,7 +3719,9 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 {
 	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
 	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
+	int beauty_map_fd = bpf_map__fd(trace->skel->maps.beauty_map_enter);
 	int err = 0;
+	unsigned int beauty_array[6];
 
 	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
 		int prog_fd, key = syscalltbl__id_at_idx(trace->sctbl, i);
@@ -3643,6 +3740,15 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 		err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
 		if (err)
 			break;
+
+		/* use beauty_map to tell BPF how many bytes to collect, set beauty_map's value here */
+		memset(beauty_array, 0, sizeof(beauty_array));
+		err = trace__bpf_sys_enter_beauty_map(trace, key, (unsigned int *)beauty_array);
+		if (err)
+			continue;
+		err = bpf_map_update_elem(beauty_map_fd, &key, beauty_array, BPF_ANY);
+		if (err)
+			break;
 	}
 
 	/*
-- 
2.45.2

