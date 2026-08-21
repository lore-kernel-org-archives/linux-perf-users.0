Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94A7314D1A
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 05:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291925; cv=none; b=JXCFyb0Y77B0fDoqfntSPbk5X5cpLt7ugwOMBgxi4Rc7r/QbhEN5E6sygFnOrehtvUKh81x8GTRsRdz9lvDdJOkiRXm5ZvPtrx4GzU+JaYrU7qDPUWY7oYFHaW6N58YHb9Vt6lGJ6ctiQLBvppwg2OoAqdLKNCjK6iPLVIH9E8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291925; c=relaxed/simple;
	bh=eIWqwG7OQuYdr8I4nQUQDpRdhuRnHAGmaBRgqHra2Wg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NJLn9+yD9bHl4wiUghXlnlsLw3vZ4xy78/qnNqm3RbYajpKzp5HSLyAMG744+I7vqAXuYXrHI6HEZ1akoQwqNAVugQPNnYX7zqQzVI341ICIvWHXnlRj+T4oktIHNc2K5Zk9qV/gtXKqW14qhoZ8lHjDbBvb+HY9bdjwR7n56TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9s5qN4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9s5qN4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389E41F000E9;
	Fri, 21 Aug 2026 05:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787291924;
	bh=P0hM0M1lDwZFlKKyrMbMHrS+wGXQVj62J0snVp25hiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E9s5qN4siJkU4Oi1bawp+0WnzfgJfOYTWLz1jYRau3TZZfFAso3WuKYCLEMfEpEe5
	 hQN/VYVT/iYu5dGIL7nfczuor4PDuRmkqnpgqPs6yYFSzLVhPaTRmQtyD3mWbECgfG
	 teeO5xljmmrhiw7R9/Q8ed0CChYksqY4mxM+YPDw3SklNC/jRm9gzDzNC+ozE0UhU1
	 xzuQVr7Zw2V2rdSRRxyMRPCorB+DxBq7QA7LcUH33XIId4j1RHu4m4+AOXmQcYSypb
	 xqaZ8YSsOM9c8Gkij4fJYJtuceZYtMuO3+xBoLtTTRSP0EcryIuBq1u/BK5WYz2v4l
	 UVwz70i8tozOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf c2c: Add stdio support for the function view
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <c53d3eb3a036c250702af363b6e7ce3307aa1571.1787283281.git.jiebin.sun@intel.com>
References: <cover.1787283281.git.jiebin.sun@intel.com>
 <c53d3eb3a036c250702af363b6e7ce3307aa1571.1787283281.git.jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 05:58:43 +0000
Message-Id: <20260821055844.389E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Memory leak: L2 and L3 function-view child entries are not freed=
 on cleanup because `perf c2c` does not set `symbol_conf.report_hierarchy`,=
 bypassing the recursive deletion in `hist_entry__delete()`.
--

--- Patch [3]: [PATCH 3/4] perf c2c: Add stdio support for the function vie=
w ---
commit e1f0ed49bafb9da749fbfa14e02ab8497ae9d5d4
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: Add stdio support for the function view

This commit adds a --function option to perf c2c to print the fully expanded
three-level hierarchy to stdout, allowing its use without SLANG support,
when piped, or in scripts. It reuses the common function-view model while
preserving the boundary between utilities and the UI.

> diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-functio=
n.c
> --- a/tools/perf/util/c2c-function.c
> +++ b/tools/perf/util/c2c-function.c

[ ... ]

> @@ -1519,7 +1516,7 @@ void c2c_function__reset(void)
>  	symbol_conf.use_callchain =3D saved_use_callchain;
>  }

[Severity: Medium]
This is a pre-existing issue, but does this teardown logic in
c2c_function__reset() leak the L2 and L3 function-view child entries?

When cleaning up the hierarchy, hists__delete_all_entries() relies on
hist_entry__delete() for each node. However, in tools/perf/util/hist.c,
hist_entry__delete() only recursively deletes the child entries in hroot_out
if the hierarchy flag is set:

tools/perf/util/hist.c:hist_entry__delete() {
    ...
    if (symbol_conf.report_hierarchy) {
        struct rb_root *root =3D &he->hroot_out.rb_root;
        struct hist_entry *child, *tmp;

        rbtree_postorder_for_each_entry_safe(child, tmp, root, rb_node)
            hist_entry__delete(child);

        *root =3D RB_ROOT;
    }
    ...
}

Since perf c2c does not appear to set symbol_conf.report_hierarchy, won't
these child entries be orphaned and skipped during cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787283281.gi=
t.jiebin.sun@intel.com?part=3D3
