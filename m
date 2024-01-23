Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD58132C19
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969118; cv=none; b=S6OI9ZtDXK0r3Y+Qc63NWIMMPa+Y7IlxJJ8gmM9SuCTMUeis/BGV4gAtWjh6Kg6hiPOIX7A35l1CogC4K44qbbldrYU9wtkL0n0YDzD5WsDipOmwvPVqBTjRQWq7//rdg1++xhpsAqZB6WZflJXks+5tUBC3Gqv61XFIQG8sIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969118; c=relaxed/simple;
	bh=Wum8BJYj+T8SQW/eKNJQdcRou+VBvV/PoXpX8a7b+BA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TbPsYtTYWmbih/qqx0s2BCl023AKAcunQ5jnZFu7h5EbKWK+9y88ZWL8p70QxLzT25zTngaSkCit06gmLGVJVqdoWifSaSzLVhKx7LIUF321v6UMq1CD4W4H5jc37Vq76GJ/9ff4j9ksW11XSth8pl8GC5HgjUqm8gYRqWt2O1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjLAOtWG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjLAOtWG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d72d240c69so33205ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 16:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705969116; x=1706573916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wum8BJYj+T8SQW/eKNJQdcRou+VBvV/PoXpX8a7b+BA=;
        b=UjLAOtWGf3GPxISL/p6FR9uEmkw5YJYNWsgd775kKiULwOYS8r6J7O18I7+WnkWtVu
         e9yEqniuBXuQSeQkDoW0bLR8bzXHrQiqO68y/CdSPYTsiQhsSNKKEd44++1kA/ogLS2R
         zazB3RCFbZQ1QOADfmxmpUwTUd7jwjW9P+goXaraJ0hR1U1IMDeumy+Ky4geeCOKW1KD
         VT1hdEGITYRZaEkNBPwwwG4xy7PW2+Y8Y0IWVHFVDia6CER3eplc0C9+CFVGWrO9rrMO
         TqZEPe/YdHaNvsxZs3Gl8cOM0xzQzopx972dz9UtCuf++9NWS/fS1udM/zdZl6Xr7BWZ
         s3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969116; x=1706573916;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wum8BJYj+T8SQW/eKNJQdcRou+VBvV/PoXpX8a7b+BA=;
        b=CYrrR1ydBD3dljwi6sA10N33fbIhc9oKe7f3Qh70aY7+8PdYJsxPEl0C4/zOjrAV5u
         HZ+CmQkkZBK9Apb8AbraUQGbiQLt6eTZByg9Ta64ehat0mh3pl/+iHI2yvtsWPcO6vse
         BGLnvYAG1ZQSWC8YH6VSaSw8BC3MYtQ0HOgq2GGeDPzCGUTfcd7ixdyzF7DMOTF3bbL+
         o45cUdQDaeXbW5aOMmSWcpWtCaLSV8QQZQHxreCAu5QnYwCSdkeOcveUfBVI1dTk+t9X
         aKc8CzGwSaF4LUBJkpAzpE/1IIFRdnJynk0Ffj8/GVDyPSHohzcBvb/efnBf+NWqKq9b
         QqFQ==
X-Gm-Message-State: AOJu0Yyx/EHGBxLW7oGBuoxWtGBK2bEzu3cmFmF6nxCQ/9TTIIKgOhM5
	5bjtN5fNMxIqcWF6CnXMkBwMdKP7qVEbHY3JhyH352JKf/kBRdzQyR6I3HQIyYPImchhE+0DmFb
	+MYEO6z94rjZyI2mTCDu1syvbIBxYWXUmsMjq8yNuXb+XRmj0vk3R9X0=
X-Google-Smtp-Source: AGHT+IGR3HJiIZxLpy0KnOUzu0aUKjwVwGb2urrMv/ETPZE4HNgQgZ059kjCAnNhTb9a5Auyfk6Ykplm7MqMOqocJqE=
X-Received: by 2002:a17:902:e892:b0:1d0:7052:aa20 with SMTP id
 w18-20020a170902e89200b001d07052aa20mr116321plg.12.1705969116212; Mon, 22 Jan
 2024 16:18:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jan 2024 16:18:24 -0800
Message-ID: <CAP-5=fU+DN_+Y=Y4gtELUsJxKNDDCOvJzPHvjUVaUoeFAzNnig@mail.gmail.com>
Subject: Better error message for kernels not compiled with BTF
To: bpf <bpf@vger.kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

if a kernel is compiled with CONFIG_DEBUG_INFO_BTF disabled then the
libbpf fails on perf lock contention with:
```
libbpf: failed to find valid kernel BTF
libbpf: Error loading vmlinux BTF: -3
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
Failed to load lock-contention BPF skeleton
lock contention BPF setup failed
```
The same error message is seen with BCC's libbpf-tools. I saw these
messages on default Rapberry Pi OS that is derived from Debian (more
context in https://bugzilla.kernel.org/show_bug.cgi?id=218401).

Given that distributions are shipping perf and libbpf-tools that
assume BTF is enabled, should CONFIG_DEBUG_INFO_BTF be enabled by
default in the kernel?

Perhaps:
```
libbpf: Error loading vmlinux BTF: -3
```
Would be better as (especially if the user is root):
```
libbpf: Error loading vmlinux BTF: -3 (was the kernel compiled with
CONFIG_DEBUG_INFO_BTF?)
```

Thanks,
Ian
