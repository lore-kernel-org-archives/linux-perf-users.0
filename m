Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957299;
	b=tYY4U8zllayt/eoMj2WA+iJLp9UHH0Aj92x8dEGyPgaPIfjqaKr9Cf4JyS9UD/7pbrMw
	 hoxobJXgxOFrozNeQke8/l+Q99efV75FupY5HEgF5xLh71DE1BuAHAKbJyz8TAuk+IOkj
	 8tG2YLCuzpWyYTXn6nox9z0sLEXcvfTw7+NPRINiA4mB2RiBi5xRmX/FHvgfkmC9JaFC/
	 cXcpwATCLQKKf/INZfLxTRyjcDpM+4u/kiGaiI0c4G1PhuocmCa4rqtOD7DXsLuXqu1FK
	 ELtvkXmOjxyd+pSkCJQe4UzLflkRE1reQ8w7M0B6tejBJs5hlnt8MhHjgB2JgljipmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957299;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=tF6lYGB3GHHcPjLERYvvI3s3/ovvVNf1Zr5qjca79do=;
	b=4YxQN0vQpLNOtXaluWCI1uFLUY6n2B6kylv8BqddtjtbPlwnWZsq5WgKx3/3Ps+V1SX5
	 H4U4DBRxfOx9StUor7gC408m/Vb8OZN3OAaCD0Ds0w7biDf9fM63AwvyKC7qM3QXL1a7Z
	 c5XipWD41rkBi8QyCi+TNZvghybbpuzwH2iMQjM+biSfmQNdSlQfk7n00lXbKmDr9MasF
	 XtvxR/YA6RM+XLYJIgypDE+kcojqIuOOlbbb+mtOUkK0Uq9ztZAsTHYXEzH/EdvQlEkTp
	 CHRoPl9c7IVPngnMs+QHcC6sJhFP9JslTaI6eLzOZL7ObRq51thxpmBvU2E91Wj69bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BCB606A326;
	Fri,  6 Nov 2026 09:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35BCB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Cx_9Kune1qzQUdAA--.18482S3;
	Fri, 06 Nov 2026 17:28:14 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxRs2one1qAMEyAA--.25383S2;
	Fri, 06 Nov 2026 17:28:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] perf tests: Fix and improve watchpoint tests
Date: Fri,  6 Nov 2026 17:28:06 +0800
Message-ID: <20261106092808.6914-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxRs2one1qAMEyAA--.25383S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9qb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
	87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
	IYc2Ij64vIr41l4c8EcI0En4kS14v26r1Y6r17MxC20s026xCaFVCjc4AY6r1j6r4UMxCI
	bckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

This patch series aims to fix a potential logic bug and improve
the debuggability of the watchpoint tests in the perf tool.

Tiezhu Yang (2):
  perf tests: Assign return value of ioctl in wp_modify test
  perf tests: Use TEST_ASSERT_EQUAL for all watchpoint tests

 tools/perf/tests/wp.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

-- 
2.42.0

