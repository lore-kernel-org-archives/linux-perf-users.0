Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CCF1B3925
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Sep 2025 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926770; cv=none; b=b867oAdXWZQ4/qXSGhJwpj0JroW9fnckqF3EekZOsjTtiGl3IdsdsQ0YRH+6AS13k+Jwa4oDmW6BdXz+nbGsCiAHZiE7RNAfgGAGv0lDLb9Ri5hHgMbl1DlY2g+7U4Yd3y995CwkCufnvf3JSmt1HdPcbsFp6IwIh2bag78S4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926770; c=relaxed/simple;
	bh=aVLAvDuzjvZUq4o1w0WdiuksjsM3bmOCj0ux9RfpkFc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=D+ssjnQYPPWEW6igA8TvWp87Z3pdcJwPeJFxO7v1//QcLQa8CenW2HBzUV3V/LyRf6MJ+ZSMmeRnJWk2whonvjGCjSufn+AzTx3my4L054EnWASqylIR6a43F1TZ/xAK6rqpKCcU9hk66RgFsj5cjl/bBDpjz+gk5QEO00Damy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWKny/ht; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWKny/ht"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-634a4829c81so4103018a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Sep 2025 15:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926767; x=1759531567; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0XcUmbDIm9A8aHJ2IMOdtvaZQ6t8E9f+KkDqK772Fo=;
        b=ZWKny/htVsoqKThzah9+H/u+WP8YCFrb2pjPVyf7/dUPkFajLRlMqoK/c5zwIDyNPa
         b1MlIPsARVIitkGP80665CUXy6iN0XMBnsbFy0ALRlTwGj5UfbeVxqBxQe/tdp/8TpVv
         OaUVt4fRl2OKgcF9hMzOvVB+fgborAELlqFqDjCTXgbNLwFlCt/TbXDWC+4qW085obDz
         GqObzWJzpBucKLGDZketQ3GhTXBHHAnxKG9b6m361ZM/xDYLpg2p6Vxqxp0kd1goeZRO
         k6fE+QIkiGr3n/eK7Q8BVZIFEIWBZTvLO27D2mzixTtmuKO1k2MkppS3AwvI3PkwVoYU
         snjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926767; x=1759531567;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0XcUmbDIm9A8aHJ2IMOdtvaZQ6t8E9f+KkDqK772Fo=;
        b=vk4xHJ8iXOffLr9BSV+OdxdPJEH2omA9fMziOAbFWIhtQjKR1GuImWVhMC8LYl861m
         eWnSBj3EaEDNmIn/PbZy+DfzxM1uHlhayhQVsQL3909bft3rin2O+s1Gy9xZVjM50u3g
         puaZ7JNIM7TZ7b+K2crzSXYsQz1YyeYCpk861snCft06QP2Q/3Rqpf0kSUrEU071mwbv
         x0RCzlAB4i8z7uZoegJabg54hU48sbhMLjCtyk//DqY201GAChJuOuSJIbPdJlz1ajla
         G+r5epH+fBlHFKOun0gE0zO2o1o6ZUF/vsIqWMiMfv80gM7LJoYJ3um//jFWqwhsLQov
         +4MA==
X-Gm-Message-State: AOJu0YypwoMJ0oHXZ1pJhapnM9q3rembqimDAI+9CwR44rWMMh52JzUx
	ScsXnOeNXeAFoEEDFueQLs6Ps31FMpnwt1ujeFc089LV/ewnSEIb+14=
X-Gm-Gg: ASbGncsDwTCCqVAcmduMXLNsdyhB+ttk5ra7hftKIcs9cUubpLE3yOp+Vu9cKUyTRSK
	zdbV3apttPRDr7ISCRgZvD5Mr7iH22PPtJwb4xYRAJVL+m6cC7nZKpUQzJhhXwFNafyZ21RC7A/
	NxjiQ/o+ji3A6irBM1eNIPXh59fFAf34ZW08G9RNN+FSEGLC2DYJkcn3kXNwjSEHJ8THTPtGH+8
	XczMJvm1sK8xK/VF6kbhstJ8rJA3wK/pD8utydTxnMJqm0nyT2wCTZYi9ruxAkOG5W77dskky39
	+gpzcO40QquiS9ZIOyzZAWhb+drnbG00s0sCVHa8oGCV6SyTsO72wNhc+jjdsuJpXYHkCuZxZGz
	3qMR4QJp1+YYNrTsWC7PTKgQ5w+C5JX10E3LSzGO9NAm3En4/hB4Qu8A2/0Fjk7E/z98Qf3stcV
	BBrZFk/bd29Mszve1N9BBRFKalPMyGSqJyticvI/o/PGtaGX9Hj2fVcQA3euJIpCU=
X-Google-Smtp-Source: AGHT+IEgUt5ke5XNe6uNWf2k/utNyZVhDSWziVn5R9T8tXuQhiIvIALdk0ct3EdeGF/jA1gp8kFcMg==
X-Received: by 2002:a17:907:7f0f:b0:aff:16eb:8b09 with SMTP id a640c23a62f3a-b34b6449b22mr908248066b.5.1758926767146;
        Fri, 26 Sep 2025 15:46:07 -0700 (PDT)
Received: from smtpclient.apple (2001-1c00-3b81-9100-e596-dd7e-500a-9b8c.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b81:9100:e596:dd7e:500a:9b8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7506sm443091466b.52.2025.09.26.15.46.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2025 15:46:06 -0700 (PDT)
From: Aniruddha Deb <aniruddha.deb.2002@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: [BUG] linux/arch/x86/events/intel/uncore_snbep.c: MCx Channel PCI
 devices are swapped around
Message-Id: <AB0DE99B-34C1-4BDC-B9C4-15E85BDBF5FA@gmail.com>
Date: Sat, 27 Sep 2025 00:46:03 +0200
Cc: linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: acme@kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 namhyung@kernel.org
X-Mailer: Apple Mail (2.3776.700.51)

Hi perf subsystem maintainers,

The iMC PMC=E2=80=99s in the haswell-EP subsystem have their PCI device =
ID=E2=80=99s swapped around. According to page 109 of =
https://www.intel.com/content/www/us/en/content-details/671052/intel-xeon-=
processor-e5-and-e7-v3-family-uncore-performance-monitoring-reference-manu=
al.html, MC0 channel 0 and 1 map to 0x2fb4/5 and channel 2/3 map to =
0x2fb0/1 respectively. Have attached a small patch illustrating the =
same.

--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3118,32 +3118,32 @@
 	{ /* MC0 Channel 0 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb0),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb4),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 0),
 	},
 	{ /* MC0 Channel 1 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb1),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb5),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 1),
 	},
 	{ /* MC0 Channel 2 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb4),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb0),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 2),
 	},
 	{ /* MC0 Channel 3 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb5),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb1),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 3),
 	},
 	{ /* MC1 Channel 0 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd0),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd4),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 4),
 	},
 	{ /* MC1 Channel 1 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd1),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd5),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 5),
 	},
 	{ /* MC1 Channel 2 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd4),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd0),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 6),
 	},
 	{ /* MC1 Channel 3 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd5),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd1),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 7),
 	},

I came across this when reading the perf subsystem code to see how =
offcore memory controllers are accessed, and where the addresses are =
defined. Haven=E2=80=99t had the chance to test it out on hardware yet, =
so please let me know if the intel document is wrong and the values =
entered are correct in practice.

Thanks,
Aniruddha.=
