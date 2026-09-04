Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D8488763
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525354; cv=none; b=Pbhjh+JKkiNk2AyW6lxQjiIozPSNlbHe+L4s4OF7pvh0malH23wDGJLnufSjWfHikNRuOvZZ24y3bzLwNSSJ42Uf70/KcoX8r3CCV/1Bm7VTpPVzgK+qQbpuFYsyWpnq5hR8IWBiSrZsx5Akh07Yvnk2+5hI+zuHWsG82H+Li4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525354; c=relaxed/simple;
	bh=DeS+VD1yPFqoI6SUo0CVGOrpqwFRMspgLs2melatTvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCZojtJhlWgDfF64g/2a3IwtZIMdNlQNv7Sq0YBJuKg6l5iXjkzIHdq9p9FL0AA+aZdRbHwKSTZNEh+gsnrzH+DPZKf+txqx5W7jYhoXuibMYAJOFztlTH8hsoDbVsQeNr+MqJb7co2AQ+Pbw8I8VBCC4p+0j/Yn4Hd2tWOdX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHadmkoL; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHadmkoL"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b1b1cb72d0so478750eaf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Sep 2026 05:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525352; x=1789130152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ye8hj6N2qvNGA2gMQYOs4PavKXmbhFPMCLKjkjvEeRo=;
        b=kHadmkoLcZclDbd0t7+3FYXKNZ1Q1ied4+gnv8JVO6zqaXvv0kwPj9mqWR6wHRmBC/
         giwO2S0I9PzU2CFz7Jmdf/xJJQeT3PNc5KL8rjIUCpn1dVG9ovmiHe9UiEbu9zJj/IAd
         TZ55jvbDKoRo+mWofB4omN2ZjtonWfNjpYf2XTTQi5CShlK1yx3LzC1h1C3CGBE9juv5
         BgyLTQ+bY6rHfEg9Q+4ZxWd6AsER6Fots2ZK0MjHHOYMNzse2HEqk1nR/HbuRTh4LKvk
         Mu0hheb8F1//nofzcaMgXj0K85Nw+kuS3YB1L+D2uX9UZKYkSha7YgU8TWGsAOmUBOWb
         UG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525352; x=1789130152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ye8hj6N2qvNGA2gMQYOs4PavKXmbhFPMCLKjkjvEeRo=;
        b=CIA3lq01ENcKVq6NkPNeGFOqiQtR5C/lR1LX9ql3fvyCz6IsMlwxaJUGH1HIg44D3Q
         Pf+KQmR7Hvb/gdRvF1U2ijHNkgwJ4MU/+VGPOCyZly8P7h5ka1BgnhUlsWFzzftJsSLn
         62MpO3o1hVEM2AmYVuKMSIweHqK9d19IgOwzJhugPNdFeGgdGKa/oOhcuunXpwvrpqwK
         8pwX7ACmX0ooxCWWOqLeCGt9zV7mgkkVD+QLlgrG4cJ6Hh99d3sPcRcf0NkNbqNPzAfr
         vCiFIvgDtsmBRrZgmx8qG6hCMVvAUHvrLKmdGsPRJ3cB1hMXCt5tedIKP3+SmK4aDVGy
         Mu2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwMYRvZ/iKgHIiBtOL/ioaNHq17j2LBsTfZ1KpibKbRaDVqWQMitYcLKaESu+lmM8hUH31caJsWm7jIzvshg/kE@vger.kernel.org
X-Gm-Message-State: AFuF++m32wqSW0DrdwGklEXV8l7odjPqJBzVn1zeBNJlmqqtFnf0z6sq
	VI9ZrmSrC7QKYfQxsMfCWar6cZhYEFa1gT3URykuO3PxRy3HBT5Wn0qn
X-Gm-Gg: AYBFou0jpVQuihPXtqJWtC1mOVHJjYJKu2WcB5AtfdWXMBYJVLTMsQfVXtBiBnhj5N+
	zdEvRyaDGlUPVxABkzh/8fi143NbHZMkNZQm4BtameSz3FAIVPHHbrD1WRciG1QBxghc9NXT/cp
	QiwZYsY4fEX9fxHPcngYaQ9jMEBOsMStif+3o0hqV3oCFbzNyDh4nx4Tt/lYvY96TFycR/aC0+E
	WZdIll40zRclKZhTmBQX7GeIcClIvFyPbVhpy3lnYqV0Z6L789tGlUZUUzR41kwFOZSXGeUemdS
	Cl4Co36nsN2yNZJW3Bfm8WUye3w4DqRaNuiHzZ4fkO1Kk+Z0WUYggSRoAFiGnvEAHzGA/LVKBvW
	aiCfJ9Oo6EXSMrfdhCRojsJ7O0PAIYDZTiYxprk8OUauauSdMPRFTUfE1IW6MeeTilbRf/MRpWW
	3kxBC7pwk45HfLCNQCM1cpSA20D5laDY/g85uGo46mNvL9fctrgKFw7DsSNmLqZ9b5DF9s3IXiy
	gvOgh617sc2DBw=
X-Received: by 2002:a05:6820:f00b:b0:6aa:f585:aabb with SMTP id 006d021491bc7-6b6fa7e38a4mr3826883eaf.1.1788525351811;
        Fri, 04 Sep 2026 05:35:51 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432423f99fsm6229374c88.1.2026.09.04.05.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:35:51 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf: fix typo "binded" in comment
Date: Fri,  4 Sep 2026 18:05:39 +0530
Message-ID: <20260904123541.38602-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904123541.38602-1-hemanth.selam@gmail.com>
References: <20260904123541.38602-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "binded" to "bound", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/perf/dwc_pcie_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 6b9ed59de26e..e2435ccc04ca 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -639,7 +639,7 @@ static void dwc_pcie_pmu_remove_cpuhp_instance(void *hotplug_node)
 }
 
 /*
- * Find the binded DES capability device info of a PCI device.
+ * Find the bound DES capability device info of a PCI device.
  * @pdev: The PCI device.
  */
 static struct dwc_pcie_dev_info *dwc_pcie_find_dev_info(struct pci_dev *pdev)
-- 
2.48.1

