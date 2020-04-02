From: James Clark <james.clark@arm.com>
Subject: [PATCH 0/1] perf tools: fix compilation on Arm
Date: Thu,  2 Apr 2020 14:41:27 +0100
Message-ID: <20200402134128.14493-1-james.clark@arm.com>
References: <20200330131810.GC31702@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200330131810.GC31702@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnaldo.melo@gmail.com, shikemeng@huawei.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo,

This patch seems to break the build for me on your
perf/core branch but adding the header fixes it.


Thanks
James

James Clark (1):
  perf tools: fix compilation on Arm

 tools/perf/arch/arm64/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.17.1
