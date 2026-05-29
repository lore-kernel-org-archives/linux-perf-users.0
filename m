Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68935E1C1
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037446; cv=none; b=aw9cxrILb+TQiAS1dmItVJbH+vaIpTWh/OphePhM8/bcaxqgSJGeM8HzI576MlJbAPfNQdSXCwy/BXSpYSqDonK6vPbtkzJMIymK7bNStQLE7Xw3LC/UG+2J1iNBJuXArxWEbnI0M9ynqFA6GnOk1ytNZz07Z4pdu3Z3wYhYRhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037446; c=relaxed/simple;
	bh=ZzSyHONJflj3efN3iccXa2QiAHCxlRP6KBZP3LlVxtg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m7vFTw6628YxF2BdbbgCNUz+JfDhmyQGpR0JQoGpkb0ngju5r1//wzgytwBomTWFXAdgWckrhqKMVlUXvA4Vi0hX5yL4t/exGQx1X3OHmcN2m60+7ejdjNcmSI1xMYPI3Pi4w8mCkLkqGdPJEqOq4EFb6YbdvZ+P4vYDDNtXry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwnZkM6Y; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwnZkM6Y"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b9d265355so705290a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780037444; x=1780642244; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is2yEBAROvB5EB2jldyJiLF6pd7FhjvHXATJbOB/v9E=;
        b=jwnZkM6YCBuStLIW0P5cUej/lV5mS802mnMk0/CaFhAyzcgtMOMcK1L/j5vRv2dUOu
         lSFGOdm78iptUP0b7nPoWa8Y2QgO4OioF/olw0DVSPbRZssEtQlVvFaqULX4C5+HTLcM
         oUdPUbZKtG9MsRMJczHayTMWrqJiyQGG6qys7F9AT/UpaLD2KrJi1eucq1tU7A2isFgX
         vFPxOYln3hdebiQ9bGvJm6f1B9EuJYrA6dxooDI0+cNRXdGSYnFJOOnlAkaMXlhrS9F9
         +XtTCIwr54Gn3c8aIzp1YDOh1lEi5LcyaOK6vZIiiFKn2SXlXAPlcn4p+kHoQKdJnAcg
         DAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780037444; x=1780642244;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Is2yEBAROvB5EB2jldyJiLF6pd7FhjvHXATJbOB/v9E=;
        b=Nbt25c87EyFudD0E1L5wXUfcW3x4JIPbh6/28aO5qmRK8l0tPmUx/JLFgQCTviw6Ei
         gPFCqu1ICeejGrnl4Q2QlZIbOUVFLzWBNMPbtmH30VJ/68OsODyvZ6YeDtsHf0Bf5IQW
         jMwxWScQ2RzjA+ODwaUgBqIw426kphkwx1655S5HIC6KkA/SEsvZmOOEjJwAnlimUJxz
         QORcCqz1yKBSyZkWAd9fzY2IGNjLna3/acBd6veGROt5cJH/16jz6TTThHIv0EVV3cNS
         xmogZnnWfhTDkK6cn+dPH4Cd5H1zHqYwvRz8HTv9+9hwR1J9Ov0BTpdez0ixDYp4teoM
         r7DA==
X-Forwarded-Encrypted: i=1; AFNElJ96tyQ2MoTlsfu6O1k2saeygRH1OgMBXnhYJvke9vGxWLrwZrk4UfHDOO9NFiw4RuOFDbuEL4lCRIvaxQdgXQOB@vger.kernel.org
X-Gm-Message-State: AOJu0YxtTe0us+1HZ9/rJhd/76596qmP44eR9ijm6TzjehM4SH0oDcee
	tiEoN2cVCZRRYxq8p3DmmWqrJUJhmzQ8TY7+h2EZUCG045xRVgzoEosu
X-Gm-Gg: Acq92OFbSLGMlvM9n/o+RlcQ+yJHiBwdQkq95Cii4qQQ3CFxve5+Z4llDzttKZVOWA7
	Ap19puFpMcd5X/UctvVG3l48+8d0cDGfJ1yJDJZWXsYKYuTHfN3i4NF/ygbbIM4aAbOg17ugDvT
	97Nn1IBVL1sGhIxYd7IE3OmOeRh65BCtn4wEbNjqLZ46Tj8CEbhA13SOLt664cypNtzoVTKot/N
	riaUq/Zq/gJgfV5hmHgAkApxbjlDW25NoMTloPEIfEpnMIRJqSzVYH6wL+nPUTP+l8Jd1jEmW1J
	50Pu0QOFi+YMbCQouBc8PKJD9yWHHZSioeb3tCM6PwC3flyEyS07m8Z9lzZQ8f7n6DNTe5xCfmx
	ynw42IJmF8axtZ7dPdlDcwK1E2oKaULdIsfW8/mSVa5X6Y+fwue9wS6HLBIdWv2OmFhu2zSo5TJ
	u7YRe6/E6ZFTQOw2R1/PESAUKi2oILYnw5F4OdBQ==
X-Received: by 2002:a17:90b:562d:b0:36a:cd8c:ad3d with SMTP id 98e67ed59e1d1-36bbceb34bbmr1987360a91.22.1780037444277;
        Thu, 28 May 2026 23:50:44 -0700 (PDT)
Received: from [127.0.1.1] ([104.28.157.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0c1ab21sm952626a91.14.2026.05.28.23.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 23:50:44 -0700 (PDT)
Subject: [PATCH 5/6] perf/sched: replace list_first_entry with
 list_first_entry_or_null
From: Wang Haoran <haoranwangsec@gmail.com>
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 haoranwangsec@gmail.com
Date: Fri, 29 May 2026 14:50:32 +0800
Message-ID: <178003743298.62097.12296428897032273088@gmail.com>
In-Reply-To: <178003738371.62097.10360938456907564684@gmail.com>
References: <178003738371.62097.10360938456907564684@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>From f66a328ea7a6832689b8d19f4643f31b8caf1e28 Mon Sep 17 00:00:00 2001
From: Wang Haoran <haoranwangsec@gmail.com>
Date: Thu, 28 May 2026 15:18:07 +0800
Subject: [PATCH 5/6] perf/sched: replace list_first_entry with
 list_first_entry_or_null

list_first_entry() is unsafe when called on a potentially empty list:
it computes container_of() on the list head itself and returns a
garbage pointer rather than NULL, so any NULL check on the result is
dead code.

get_all_cpu_stats() and show_schedstat_data() call list_first_entry()
on lists that are populated from user-controlled perf.data content,
making them reachable via crafted input.  Replace every such call with
list_first_entry_or_null() and add the corresponding NULL guards.

Fixes: <get_all_cpu_stats / show_schedstat_data>
Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
---
 tools/perf/builtin-sched.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index ab4c9ffa4..55391f0b1 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4170,7 +4170,7 @@ static void summarize_schedstat_domain(struct schedstat=
_domain *summary_domain,
  */
 static int get_all_cpu_stats(struct list_head *head)
 {
-	struct schedstat_cpu *cptr =3D list_first_entry(head, struct schedstat_cpu,=
 cpu_list);
+	struct schedstat_cpu *cptr =3D list_first_entry_or_null(head, struct scheds=
tat_cpu, cpu_list);
 	struct schedstat_cpu *summary_head =3D NULL;
 	struct perf_record_schedstat_domain *ds;
 	struct perf_record_schedstat_cpu *cs;
@@ -4212,8 +4212,11 @@ static int get_all_cpu_stats(struct list_head *head)
=20
 		cnt++;
 		summarize_schedstat_cpu(summary_head, cptr, cnt, is_last);
-		tdptr =3D list_first_entry(&summary_head->domain_head, struct schedstat_do=
main,
-					 domain_list);
+		tdptr =3D list_first_entry_or_null(&summary_head->domain_head,
+						 struct schedstat_domain,
+						 domain_list);
+		if (!tdptr)
+			break;
=20
 		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
 			summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
@@ -4229,7 +4232,8 @@ static int show_schedstat_data(struct list_head *head1,=
 struct cpu_domain_map **
 			       struct list_head *head2, struct cpu_domain_map **cd_map2,
 			       bool summary_only)
 {
-	struct schedstat_cpu *cptr1 =3D list_first_entry(head1, struct schedstat_cp=
u, cpu_list);
+	struct schedstat_cpu *cptr1 =3D
+		list_first_entry_or_null(head1, struct schedstat_cpu, cpu_list);
 	struct perf_record_schedstat_domain *ds1 =3D NULL, *ds2 =3D NULL;
 	struct perf_record_schedstat_cpu *cs1 =3D NULL, *cs2 =3D NULL;
 	struct schedstat_domain *dptr1 =3D NULL, *dptr2 =3D NULL;
@@ -4250,10 +4254,14 @@ static int show_schedstat_data(struct list_head *head=
1, struct cpu_domain_map **
 	printf("\n");
=20
 	printf("%-65s: ", "Time elapsed (in jiffies)");
+	if (!cptr1)
+		return -EINVAL;
 	jiffies1 =3D cptr1->cpu_data->timestamp;
 	printf("%11llu", jiffies1);
 	if (head2) {
-		cptr2 =3D list_first_entry(head2, struct schedstat_cpu, cpu_list);
+		cptr2 =3D list_first_entry_or_null(head2, struct schedstat_cpu, cpu_list);
+		if (!cptr2)
+			return -EINVAL;
 		jiffies2 =3D cptr2->cpu_data->timestamp;
 		printf(",%11llu", jiffies2);
 	}
--=20
2.53.0

