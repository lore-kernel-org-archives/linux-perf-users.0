Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C727F163;
	Wed, 12 Nov 2025 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979800; cv=none; b=UsvSKMkWtDz0BCMCHg2CHPrvUL7fn0iNitZ84HymclJOUlBiMHJuzZB3h7l58HX8JiBTWX+t2KgY9cDxZUl0/wfrMoUE1wAx6nJ1VYAxwxQ5gquZ412gHpaKGqe34pjNltaKh2fruzsEjrci5RvncvKKE65LAm6BcIoQTB/+w5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979800; c=relaxed/simple;
	bh=OzkJp3iyLCFp854XG9Kfo3VPKCTB6+38vEjgcKha5Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPVZtVKuUWVhtYDVpiUgpfnUFzOqrVCy0Fg6tJWQsAuji0B6fOXz59FD3E/DPR9t7aEnuIzpf51MoM+aUnvkO8ocOuu25Wfv3DcsbJKvVQaKOEotgraEZQtTiWDAEocp1k0GYrnnjL1vMElQciCQM++xY6czuMXn7OXb22DApHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kp57rjur; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kp57rjur"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=s9o8NRvJdzTieC05I6sj+VphdIDRCWgXCmaEd+EQUzE=; b=kp57rjurHJAHd7F+xCvQZd2no/
	zldsm/PODHXAoZPRO03KjAvh+i6TFvDrouKIddaHozeoKX6h2p6XnR40qvkW2IfcfJjSqtjOOASHE
	pcLUkbSjzs9jrpSZ1b8HCTaxH2HZB+iIqy3JOelzm0XwDoUm+rsEL547/n1nbkk1Zdvdon9bDW7m/
	fbDrR+VT28Mw+bAffi2/e9rYJYquUsYKCdFL34XhsCio+W3x5wyTN9hfghxd3d7PyPKLuC/rsdqJN
	omr01SQUfqZXqu1vGLmq3jMm7SSbX5suEPyADu3Kw4ySsNlAUtR/0apBO+uhzbLc6bklHuhuBZo+/
	5LaH1Fjg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJHZx-00000006TTz-1U22;
	Wed, 12 Nov 2025 20:36:33 +0000
Date: Wed, 12 Nov 2025 20:36:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev,
	workflows@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v8 00/27] mm/ksw: Introduce KStackWatch debugging tool
Message-ID: <aRTv0eHfX0j8vJOW@casper.infradead.org>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
 <aRIh4pBs7KCDhQOp@casper.infradead.org>
 <aRLmGxKVvfl5N792@ndev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRLmGxKVvfl5N792@ndev>

[dropping all the individual email addresses; leaving only the
mailing lists]

On Wed, Nov 12, 2025 at 10:14:29AM +0800, Jinchao Wang wrote:
> On Mon, Nov 10, 2025 at 05:33:22PM +0000, Matthew Wilcox wrote:
> > On Tue, Nov 11, 2025 at 12:35:55AM +0800, Jinchao Wang wrote:
> > > Earlier this year, I debugged a stack corruption panic that revealed the
> > > limitations of existing debugging tools. The bug persisted for 739 days
> > > before being fixed (CVE-2025-22036), and my reproduction scenario
> > > differed from the CVE report—highlighting how unpredictably these bugs
> > > manifest.
> > 
> > Well, this demonstrates the dangers of keeping this problem siloed
> > within your own exfat group.  The fix made in 1bb7ff4204b6 is wrong!
> > It was fixed properly in 7375f22495e7 which lists its Fixes: as
> > Linux-2.6.12-rc2, but that's simply the beginning of git history.
> > It's actually been there since v2.4.6.4 where it's documented as simply:
> > 
> >       - some subtle fs/buffer.c race conditions (Andrew Morton, me)
> > 
> > As far as I can tell the changes made in 1bb7ff4204b6 should be
> > reverted.
> 
> Thank you for the correction and the detailed history. I wasn't aware this
> dated back to v2.4.6.4. I'm not part of the exfat group; I simply
> encountered a bug that 1bb7ff4204b6 happened to resolve in my scenario.
> The timeline actually illustrates the exact problem KStackWatch addresses:
> a bug introduced in 2001, partially addressed in 2025, then properly fixed
> months later. The 24-year gap suggests these silent stack corruptions are
> extremely difficult to locate.

I think that's a misdiagnosis caused by not understanding the limited
circumstances in which the problem occurs.  To hit this problem, you
have to have a buffer_head allocated on the stack.  That doesn't happen
in many places:

fs/buffer.c:    struct buffer_head tmp = {
fs/direct-io.c: struct buffer_head map_bh = { 0, };
fs/ext2/super.c:        struct buffer_head tmp_bh;
fs/ext2/super.c:        struct buffer_head tmp_bh;
fs/ext4/mballoc-test.c: struct buffer_head bitmap_bh;
fs/ext4/mballoc-test.c: struct buffer_head gd_bh;
fs/gfs2/bmap.c: struct buffer_head bh;
fs/gfs2/bmap.c: struct buffer_head bh;
fs/isofs/inode.c:       struct buffer_head dummy;
fs/jfs/super.c: struct buffer_head tmp_bh;
fs/jfs/super.c: struct buffer_head tmp_bh;
fs/mpage.c:     struct buffer_head map_bh;
fs/mpage.c:     struct buffer_head map_bh;

It's far more common for buffer_heads to be allocated from slab and
attached to folios.  The other necessary condition to hit this problem
is that get_block() has to actually read the data from disk.  That's
not normal either!  Most filesystems just fill in the metadata about
the block and defer the actual read to when the data is wanted.  That's
the high-performance way to do it.

So our opportunity to catch this bug was highly limited by the fact that
we just don't run the codepaths that would allow it to trigger.

> > > Initially, I enabled KASAN, but the bug did not reproduce. Reviewing the
> > > code in __blk_flush_plug(), I found it difficult to trace all logic
> > > paths due to indirect function calls through function pointers.
> > 
> > So why is the solution here not simply to fix KASAN instead of this
> > giant patch series?
> 
> KASAN caught 7375f22495e7 because put_bh() accessed bh->b_count after
> wait_on_buffer() of another thread returned—the stack was invalid.
> In 1bb7ff4204b6 and my case, corruption occurred before the victim
> function of another thread returned. The stack remained valid to KASAN,
> so no warning triggered. This is timing-dependent, not a KASAN deficiency.

I agree that it's a narrow race window, but nevertheless KASAN did catch
it with ntfs and not with exfat.  The KASAN documentation states that
it can catch this kind of bug:

Generic KASAN supports finding bugs in all of slab, page_alloc, vmap, vmalloc,
stack, and global memory.

Software Tag-Based KASAN supports slab, page_alloc, vmalloc, and stack memory.

Hardware Tag-Based KASAN supports slab, page_alloc, and non-executable vmalloc
memory.

(hm, were you using hwkasan instead of swkasan, and that's why you
couldn't see it?)

