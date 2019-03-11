From: Andi Kleen <andi@firstfloor.org>
Subject: Misc improvements and bug fixes for perf
Date: Mon, 11 Mar 2019 13:24:36 -0700
Message-ID: <20190311202446.10210-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Mostly unrelated to each other, so can be picked'n'chosed.

- Fix perf stat --no-scale
- Support --reltime in perf script
- Fix crashes with stat -r
- Handle JITed code better in perf report
- Allow to limit rotated perf.data files
- Filter metrics in perf list
- Show all sort keys in perf report help
- Fix multiplexing formula

Also available in
git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc perf/misc-fixes-4
